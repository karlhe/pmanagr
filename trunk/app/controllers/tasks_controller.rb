class TasksController < ApplicationController
  before_filter :login_required, :only => :assign
  
  def assign
    @task = Task.find(params[:task_id])
    @user = current_user
    @assignment = Assignment.new
    @assignment.task = @task
    @assignment.user = @user
    if @assignment.save
      flash[:notice] = "#{@task.name} has been assigned to #{@user.name}."
      redirect_to project_task_path(@task.project,@task)
    else
      flash[:error] = "Failed to assign task."
      render :action => :new
    end
  end
  
  # GET /tasks
  # GET /tasks.xml
  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find(params[:id])
    @assignments = @task.assignments

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    @project = @task.project
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build(params[:task])

    respond_to do |format|
      if @task.save
        flash[:notice] = 'Task was successfully created.'
        format.html { redirect_to project_task_path(@project,@task) }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = 'Task was successfully updated.'
        format.html { redirect_to project_task_path(@task.project,@task) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    @project = @task.project
    @task.destroy

    respond_to do |format|
      format.html { redirect_to project_tasks_path(@project) }
      format.xml  { head :ok }
    end
  end
end
