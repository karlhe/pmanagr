class TasksController < ApplicationController
  before_filter :login_required, :only => [:assign, :new]
  before_filter :check_project_member, :except => [:show, :index]
  before_filter :check_admin, :except => [:show, :index]
  before_filter :check_public_access, :only => :show

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
    if completion#all tasks are complete
      if @task.update_attribute(:completed_at,Time.now)
        flash[:notice] = "Task has been completed!"
        redirect_to project_path(@project)
      else
        flash[:error] = "Failed to mark task as complete"
        redirect_to project_path(@project)
      end
    else
      flash[:notice] = "All assignments must be complete first!"
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
      flash[:notice] = "Task has been reopened."
      redirect_to project_path(@project)
    else
      flash[:error] = "Failed to reopen task."
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
    
    pm_candidates_list
  
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    @project = @task.project
    pm_candidates_list
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build(params[:task])
    
    pm_candidates_list

    respond_to do |format|
      if @task.save
        flash[:notice] = 'You have successfully created the task.'
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

    pm_candidates_list
    
    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = 'You have successfully updated the task.'
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
  
  def pm_candidates_list
    @members = @project.memberships.select { |member| member.is_approved? }
    @candidates = @members.collect { |member| member.user }
  end
  
  def check_project_member
	status = current_user.memberships.select{|m| m.project_id.to_s == params[:project_id]}.first
	unless !status.blank? and (status.is_owner? or status.is_user?)
      redirect_to root_path
      flash[:error] = 'You are not a member of this project.'
    end
  end
  
  def check_admin
    @project = Project.find(params[:project_id])
	  status = current_user.memberships.select{|m| m.project_id.to_s == params[:project_id]}.first
	  unless (!status.blank? && status.is_owner?) || current_user.is_manager?(@task)
      redirect_to project_path(@project)
      flash[:error] = 'You are not an admin for this project.'
    end
  end

  def check_public_access
    project = Task.find(params[:id]).project
    private = !project.is_public?
    if (!logged_in? and private)  || (logged_in? and private and (!current_user.memberships.select{|m| m.project_id == project.id}.first))
      redirect_to root_path
      flash[:error] = 'You do not have permission to view this private task.'
    end
  end
end
