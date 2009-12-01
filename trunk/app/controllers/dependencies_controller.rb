class DependenciesController < ApplicationController
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
    if params[:task_id].present?
      @task = Task.find(params[:task_id])
      @potentials = @task.project.tasks.select { |potential| @task.can_depend_on?(potential) }
    else
      flash[:error] = "Must specify task in order to add dependencies."
      redirect_to root_path
    end
  end

  # GET /dependencies/1/edit
  def edit
    @dependency = Dependency.find(params[:id])
  end

  # POST /dependencies
  # POST /dependencies.xml
  def create
    @task = Task.find(params[:task_id])
    @dependency = @task.dependencies.build(:prerequisite_id => params[:prerequisite_id])

    if @dependency.save
      flash[:notice] = 'Dependency was successfully created.'
      redirect_to project_task_path(@task.project,@task)
    else
      flash[:error] = 'Failed to created dependency.'
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
    @dependency = Dependency.find(params[:id])
    @task = @dependency.task
    
    if @dependency.destroy
      flash[:notice] = "Dependency removed."
    else
      flash[:error] = "Failed to remove dependency."
    end
    
    redirect_to project_task_path(@task.project,@task)
  end
end
