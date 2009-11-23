class AssignmentsController < ApplicationController
  before_filter :login_required

  def take
    @assignment = Assignment.find(params[:id])
    @task = @assignment.task
    @project = @task.project
    if @assignment.user == nil
      @assignment.user = current_user
      if @assignment.save
        flash[:notice] = "You have taken the assignment."
        #redirect_to project_task_path(@project,@task)
      else
        flash[:error] = "Failed to take the assignment."
        #redirect_to project_task_path(@project,@task)
      end
    else
      flash[:error] = "This assignment already belongs to someone else."
      #redirect_to project_task_path(@project,@task)
    end
    redirect_to project_task_path(@project,@task)
  end

  def drop
    @assignment = Assignment.find(params[:id])
    @task = @assignment.task
    @project = @task.project
    if @assignment.user == current_user
      @assignment.drop
      if @assignment.save
        flash[:notice] = "You have dropped the assignment."
        #redirect_to project_task_path(@project,@task)
      else
        flash[:error] = "Failed to drop the assignment."
        #redirect_to project_task_path(@project,@task)
      end
    else
      flash[:error] = "You don't own this assignment."
    end
    redirect_to project_task_path(@project,@task)
  end

  def complete
    @assignment = Assignment.find(params[:id])
    @task = @assignment.task
    @project = @task.project
    if @assignment.user == current_user && (not @assignment.is_complete?)
    @task = @assignment.task
      @assignment.complete
      if @assignment.save
        flash[:notice] = "You have taken the assignment."
        #redirect_to project_task_path(@project,@task)
      else
        flash[:error] = "Failed to complete the assignment."
        #redirect_to project_task_path(@project,@task)
      end
    else
      flash[:error] = "You don't own this assignment."
    end
    redirect_to project_task_path(@project,@task)
  end

  def uncomplete
    @assignment = Assignment.find(params[:id])
    @task = @assignment.task
    @project = @task.project
    if @assignment.user == current_user && @assignment.is_complete?
      @assignment.uncomplete
      if @assignment.save
        flash[:notice] = "You have taken the assignment."
        #redirect_to project_task_path(@project,@task)
      else
        flash[:error] = "Failed to complete the assignment."
        #redirect_to project_task_path(@project,@task)
      end
    else
      flash[:error] = "You don't own this assignment."
    end
    redirect_to project_task_path(@project,@task)
  end

  # GET /assignments
  # GET /assignments.xml
  def index
    @assignments = Assignment.find(:all, :conditions => { :public => true })

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @assignments }
    end
  end

  # GET /assignments/1
  # GET /assignments/1.xml
  def show
    @assignment = Assignment.find(params[:id])
    @members = @assignment.user

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @assignment }
    end
  end

  # GET /assignments/new
  # GET /assignments/new.xml
  def new
    @task = Task.find(params[:task_id])
    @project = @task.project
    @assignment = @task.assignments.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @assignment }
    end
  end

  # GET /assignments/1/edit
  def edit
    @task = Task.find(params[:task_id])
    @project = @task.project
    @assignment = Assignment.find(params[:id])
  end

  # POST /assignments
  # POST /assignments.xml
  def create
    @task = Task.find(params[:task_id])
    @assignment = @task.assignments.build(params[:assignment])

    respond_to do |format|
      if @assignment.save
        flash[:notice] = 'assignment was successfully created.'
        format.html { redirect_to project_task_path(@task.project, @task)}
        format.xml  { render :xml => @assignment, :status => :created, :location => @assignment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /assignments/1
  # PUT /assignments/1.xml
  def update
    @assignment = Assignment.find(params[:id])
    @task = @assignment.task
    @project = @task.project

    respond_to do |format|
      if @assignment.update_attributes(params[:assignment])
        flash[:notice] = 'assignment was successfully updated.'
        format.html { redirect_to project_task_path(@project,@task) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.xml
  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy

    respond_to do |format|
      format.html { redirect_to(project_task_path(@assignment.task.project, @assignment.task)) }
      format.xml  { head :ok }
    end
  end
end
