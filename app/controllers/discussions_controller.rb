class DiscussionsController < ApplicationController
  # GET /discussions
  # GET /discussions.xml
  def index
    @project = Project.find(params[:project_id])
    @discussions = @project.discussions

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @discussions }
    end
  end

  # GET /discussions/1
  # GET /discussions/1.xml
  def show
    @project = Project.find(params[:project_id])
    @discussion = Discussion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @discussion }
    end
  end

  # GET /discussions/new
  # GET /discussions/new.xml
  def new
    @project = Project.find(params[:project_id])
    @discussion = @project.discussions.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @discussion }
    end
  end

  # GET /discussions/1/edit
  def edit
    @discussion = Discussion.find(params[:id])
    @project = @discussion.project
  end

  # POST /discussions
  # POST /discussions.xml
  def create
    @project = Project.find(params[:project_id])
    @discussion = @project.discussions.build(params[:discussion])

    respond_to do |format|
      if @discussion.save
        flash[:notice] = 'Discussion was successfully created.'
        format.html { redirect_to project_discussion_path(@project,@discussion) }
        format.xml  { render :xml => @discussion, :status => :created, :location => @discussion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @discussion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /discussions/1
  # PUT /discussions/1.xml
  def update
    @discussion = Discussion.find(params[:id])

    respond_to do |format|
      if @discussion.update_attributes(params[:discussion])
        flash[:notice] = 'Discussion was successfully updated.'
        format.html { redirect_to(@discussion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @discussion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /discussions/1
  # DELETE /discussions/1.xml
  def destroy
    @discussion = Discussion.find(params[:id])
    @discussion.destroy

    respond_to do |format|
      format.html { redirect_to(project_discussions_url) }
      format.xml  { head :ok }
    end
  end
end
