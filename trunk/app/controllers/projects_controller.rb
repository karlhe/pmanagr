class ProjectsController < ApplicationController
  before_filter :login_required, :only => [:join, :new, :create, :edit, :update, :destroy]
  
  def join
    @project = Project.find(params[:project_id])
    @user = current_user
    @membership = Membership.new
    @membership.user = @user
    @membership.project = @project
    if @membership.save
      flash[:notice] = "#{@user.name} is now a member of #{@project.name}."
      redirect_to project_path(@project)
    else
      flash[:error] = "Failed to add user."
      render :action => :new
    end
  end
  
  # GET /
  def home
    if logged_in?
      redirect_to dashboard_path
    else
        @projects = Project.find(:all, :limit => 10, :conditions => { :public => true })

        respond_to do |format|
          format.html # home.html.erb
          format.xml  { render :xml => @projects }
        end
    end
  end

  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.find(:all, :conditions => { :public => true })

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])
    @tasks = @project.tasks
    @members = @project.users

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to join_project_path(@project) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(@project) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
end
