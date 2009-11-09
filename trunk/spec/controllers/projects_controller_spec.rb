require 'spec_helper'

describe ProjectsController do

  #Delete this example and add some real ones
  it "should use ProjectsController" do
    controller.should be_an_instance_of(ProjectsController)
  end
  
  describe "When creating a project" do
    it "should create a project"
    it "should set the current user to admin privileges"
    it "should add the current user to the project"
    it "should redirect to the project page"
  end
  
  describe "When joining a project" do
    it "should add current user as a member"
    it "should give the current user minimum privileges"
    it "should redirect to the project page"
  end
  
  describe "When showing projects" do
    describe "If the project is public" do
      it "should be list"
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
