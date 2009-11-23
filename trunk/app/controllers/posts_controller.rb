class PostsController < ApplicationController
  # GET /posts
  # GET /posts.xml
  def index
    @project = Project.find(params[:project_id])
    @discussion = Discussion.find(params[:discussion_id])
    @posts = @discussion.posts

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @project = Project.find(params[:project_id])
    @discussion = Discussion.find(params[:discussion_id])
    @post = @discussion.posts.build
    @post.author = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @project = Project.find(params[:project_id])
    @discussion = Discussion.find(params[:discussion_id])
    @post = @discussion.posts.build(params[:post])
    @post.author = current_user

    respond_to do |format|
      if @post.save
        flash[:notice] = 'post was successfully created.'
        format.html { redirect_to project_discussion_post_path(@project,@discussion,@post) }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'post was successfully updated.'
        format.html { redirect_to(@post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(project_discussion_posts_url) }
      format.xml  { head :ok }
    end
  end
end
