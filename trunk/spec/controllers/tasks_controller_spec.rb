require 'spec_helper'

describe TasksController do
  fixtures :users, :projects, :tasks

  #Delete this example and add some real ones
  it "should use TasksController" do
    controller.should be_an_instance_of(TasksController)
  end
  
  describe "When creating a task" do
    it "should be belong to the current project"
    it "should have a due by date after the current time"
    it "should redirect to the task page"
    it "should be shown on the project page"
  end
  
  describe "When assigning a task" do
    describe "When assigning yourself a task" do
      it "should set the current user as a user for the task"
      it "should add the task to the user's assignments"
      it "should redirect to the task page"
    end
    describe "When assigning someone else a task as an admin" do
      it "should set the target user as a user for the task"
      it "should add the task to the target user's assignments"
      it "should redirect to the task page"
    end
  end
  
  describe "When completing a task" do
    it "should set the completed by time to the current time"
  end
  
  describe "When deleting a task" do
    it "should delete all subtasks"
    it "should remove all assignments"
  end
  
end
