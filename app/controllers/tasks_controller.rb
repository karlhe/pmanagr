class TasksController < ApplicationController
  before_filter :login_required, :only => [:assign, :new]
  before_filter :check_project_member
  before_filter :check_admin, :except => [:show, :index]

  def complete
    @task = Task.find(params[:task_id])
    @project = @task.project
    @membership = current_user.memberships.select{|m| m.project_id.to_s == params[:id]}.first
    #Commented out to allow anyone to complete a task
    #if !@membership.is_owner?
    #  flash[:notice] = "You do not have the privilege to complete this task!"
    #  redirect_to project_path(@project)
    @assignments = Assignment.find(:all, :conditions => { :task_id =>  @task })
    completion = true
    @assignments.each do |assig|
      if !assig.is_complete?
        completion = false
      end
    end
    if  completion#all tasks are complete
      if @task.update_attribute(:completed_at,Time.now)
        flash[:notice] = "Task has been completed!"
        redirect_to project_path(@project)
      else
        flash[:error] = "Failed to mark task complete!"
        redirect_to project_path(@project)
      end
    else
      flash[:notice] = "Not all assignments are complete for this task!"
      redirect_to project_path(@project)
    end
  end

  def reopen
    @task = Task.find(params[:task_id])
    @project = @task.project
    #Commented out to allow anyone to reopen a task
    #if !@membership.is_owner?
    #  flash[:notice] = "You do not have the privilege to reopen this task!"
    #  redirect_to project_path(@project)
    if @task.update_attribute(:completed_at,nil)
      flash[:notice] = "Task has been reopened!"
      redirect_to project_path(@project)
    else
      flash[:error] = "Failed to reopen task!"
      redirect_to project_path(@project)
    end
  end
  
  # GET /tasks
  # GET /tasks.xml
  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks
    redirect_to project_path(@project)
    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @tasks }
    #end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find(params[:id])
    @assignments = @task.assignments
    @task.prerequisites.each do |prereq|
      if prereq.completed_at.blank?
        flash[:error] = "Prerequisites for this task have not been met!"
      end
    end

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
  
  private
  def check_project_member
	status = current_user.memberships.select{|m| m.project_id.to_s == params[:project_id]}.first
	unless status.is_owner? or status.is_user?
      redirect_to root_path
      flash[:error] = 'You are not a member of this project.'
    end
  end
  
  def check_admin
	status = current_user.memberships.select{|m| m.project_id.to_s == params[:project_id]}.first
	unless !status.blank? and status.is_owner?
      redirect_to project_path
      flash[:error] = 'You are not an admin for this project.'
    end
  end
end
