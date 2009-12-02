class DependenciesController < ApplicationController
  before_filter :task_required, :only => [:new, :create]
  before_filter :login_required
  before_filter :check_project_member
  before_filter :check_admin
  
  # GET /dependencies
  # GET /dependencies.xml

  # GET /dependencies/1
  # GET /dependencies/1.xml
  def show
    @dependency = Dependency.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @dependency }
    end
  end

  # GET /dependencies/new
  # GET /dependencies/new.xml
  def new
    @potentials = @task.project.tasks.select { |potential| @task.can_depend_on?(potential) }
  end

  # GET /dependencies/1/edit
  def edit
    @dependency = Dependency.find(params[:id])
  end

  # POST /dependencies
  # POST /dependencies.xml
  def create
    @dependency = @task.dependencies.build(:prerequisite_id => params[:prerequisite_id])

    if @dependency.save
      flash[:notice] = 'Dependency was successfully created.'
      redirect_to project_task_path(@task.project,@task)
    else
      flash[:error] = 'Failed to create dependency.'
      redirect_to new_dependency_path(:task_id => @task)
    end
  end

  # PUT /dependencies/1
  # PUT /dependencies/1.xml
  def update
    @dependency = Dependency.find(params[:id])

    respond_to do |format|
      if @dependency.update_attributes(params[:dependency])
        flash[:notice] = 'Dependency was successfully updated.'
        format.html { redirect_to(@dependency) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @dependency.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /dependencies/1
  # DELETE /dependencies/1.xml
  def destroy    
    if @dependency.destroy
      flash[:notice] = "Dependency removed."
    else
      flash[:error] = "Failed to remove dependency."
    end
    
    redirect_to project_task_path(@task.project,@task)
  end
  
  private
    def task_required
      if params[:task_id].present?
        @task = Task.find(params[:task_id])
      elsif params[:id].present?
        @dependency = Dependency.find(params[:id])
        @task = @dependency.task
      else
        flash[:error] = "Cannot view dependencies without specifying a task."
        redirect_to root_path
      end
    end
  
    def check_project_member
	    status = current_user.memberships.select{|m| m.project_id == @task.project.id}.first
	    unless !status.blank? and (status.is_owner? or status.is_user?)
        redirect_to project_task_path(@task.project,@task)
        flash[:error] = 'You are not a member of this project.'
      end
    end
    
    def check_admin
	    status = current_user.memberships.select{|m| m.project_id == @task.project.id}.first
	    unless !status.blank? and status.is_owner?
        redirect_to project_task_path(@task.project,@task)
        flash[:error] = 'You are not an admin for this project.'
      end
    end
  
end
