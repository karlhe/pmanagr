require 'spec_helper'

describe ProjectsController do
  fixtures :users, :projects

  #Delete this example and add some real ones
  it "should use ProjectsController" do
    controller.should be_an_instance_of(ProjectsController)
  end
  
  describe "When creating a project" do
    describe "if user logged in" do
      before :each do
        @current_user = users(:quentin)
        controller.stub!(:current_user).and_return(@current_user)
        controller.stub!(:login_required).and_return(:true)
        @project = projects(:newprojectn)
      end
      it "should create a project" do
        Project.stub!(:new).and_return @project
        Project.should_receive(:new)
        @project.should_receive(:save)
        post :create
      end
      it "should set the current user to admin privileges" do
        Project.stub!(:new).and_return @project
        post :create
        @current_user.is_owner?(@project).should be_true
      end
      it "should add the current user to the project" do
        Project.stub!(:new).and_return @project
        post :create
        @project.users.should include @current_user
      end
      it "should redirect to the project page" do
        Project.stub!(:new).and_return @project
        post :create
        response.should redirect_to(project_path(@project))
      end
    end
    describe "if user not logged in" do
      before :each do
        @current_user = nil 
        controller.stub!(:current_user).and_return(@current_user)
        controller.stub!(:login_required).and_return(:false)
      end
      it "should redirect away from the create project path" do
        Project.stub!(:new).and_return @project
        post :create
        response.should redirect_to(root_path)
      end
    end
  end
  
  describe "GET index" do
    it "should display a list of projects" do
      @projects = [projects(:projectp), projects(:projectq)]
      Project.should_receive(:find).and_return @projects
      get :index
    end
  end

end
