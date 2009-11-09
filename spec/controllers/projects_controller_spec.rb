require 'spec_helper'

describe ProjectsController do
  fixtures :users, :projects

  #Delete this example and add some real ones
  it "should use ProjectsController" do
    controller.should be_an_instance_of(ProjectsController)
  end
  
  describe "POST create" do
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
      it "should set the current user to admin privileges"
      it "should add the current user to the project" do
        Project.stub!(:new).and_return @project
        post :create
        response.should redirect_to(join_project_path(@project))
      end
      it "should redirect to the project page"
    end
  end
  
  describe "POST join" do
    describe "if user logged in" do
      before :each do
        @current_user = users(:quentin)
        controller.stub!(:current_user).and_return(@current_user)
        controller.stub!(:login_required).and_return(:true)
        @project = projects(:projectn)
      end
      it "should add current user as a member" do
        Project.stub!(:find).and_return @project
        post :join
        @project.users.include?(@current_user).should == true
      end
      it "should give the current user minimum privileges"
      it "should redirect to the project page"
    end
  end
  
  describe "GET index" do
    it "should display a list of projects" do
      @projects = [projects(:projectp), projects(:projectq)]
      Project.should_receive(:find).and_return @projects
      get :index
    end
    describe "If the project is public" do
      it "should be listed"
      it "should display to anyone"
    end
    describe "If the project is private" do
      it "should not be listed"
      it "should not display to a non-member"
    end
  end
  
  describe "When deleting a project" do
    it "should remove all memberships related to the project"
    it "should remove all tasks within the project"
  end

end
