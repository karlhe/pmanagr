require 'spec_helper'

describe TasksController do
  fixtures :users, :projects, :tasks

  #Delete this example and add some real ones
  it "should use TasksController" do
    controller.should be_an_instance_of(TasksController)
  end
  
  describe "When creating a task" do
    before :each do
      @current_user = users(:quentin)
      controller.stub!(:current_user).and_return(@current_user)
      controller.stub!(:login_required).and_return(:true)
      @task = tasks(:one)
      @project = projects(:projectn)
    end
    it "should be belong to the current project" do
      Task.stub!(:new).and_return @task
      post :create
      @task.project_id.should == 1
    end
    it "should have a due by date after the current time" do
      Task.stub!(:new).and_return @task
      post :create
      @task.due_by.should be > Time.now
    end
    it "should redirect to the task page" do
      Task.stub!(:new).and_return @task
      Task.stub!(:project).and_return @task
      post :create
      response.should redirect_to(root_path)
    end
    it "should be shown on the project page"
  end
  
  describe "When completing a task" do
    it "should set the completed by time to the current time"
  end
  
end
