require 'spec_helper'

describe Project do
  fixtures :projects
  
  before(:each) do
    @valid_attributes = {
      :name   => "Project N",
      :desc   => "The most secretest project ever",
      :public => false
    }
  end
  
  describe "when validating the project" do
    it "should validate with valid attributes" do
      @project = Project.new(@valid_attributes)
      @project.should be_valid
    end
    it "should validate the name" do
      @project = Project.new(@valid_attributes)
      @project.name = nil
      @project.should_not be_valid
    end
    it "should validate the description" do
      @project = Project.new(@valid_attributes)
      @project.desc = nil
      @project.should_not be_valid
    end
  end
  
  it "should create a new instance given valid attributes" do
    Project.create!(@valid_attributes)
  end
  
  describe "Given valid attributes" do
    it "should have a user with admin privileges in its memberships"  # Belongs in controller?
    it "should have a valid name"
    it "should have a valid description"
  end
end
