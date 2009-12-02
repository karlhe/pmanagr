require 'spec_helper'

describe Project do
  fixtures :projects
  
  before(:each) do
    @valid_attributes = {
      :name   => "Project N",
      :desc   => "The most secretest project ever",
      :public => false,
      :due_by => 5.hours.from_now,
      :created_at => Time.now,
      :start_time => Time.now
    }
  end
  
  it "should create a new instance given valid attributes" do
    Project.create!(@valid_attributes)
  end
  
  describe "when validating the project" do
    it "should validate with valid attributes" do
      @project = Project.new(@valid_attributes)
      @project.should be_valid
    end
    it "should have a name" do
      @project = Project.new(@valid_attributes)
      @project.name = nil
      @project.should_not be_valid
    end
    it "should have a description" do
      @project = Project.new(@valid_attributes)
      @project.desc = nil
      @project.should_not be_valid
    end
    it "should have a start time" do
      @project = Project.new(@valid_attributes)
      @project.start_time = nil
      @project.should_not be_valid
    end
    it "should have a due by" do
      @project = Project.new(@valid_attributes)
      @project.due_by = nil
      @project.should_not be_valid
    end
    it "should have a start time before the due date" do
      @project = Project.new(@valid_attributes)
      @project.start_time = 6.hours.from_now
      @project.should_not be_valid
    end
    it "should have a creation time before the due date" do
      @project = Project.new(@valid_attributes)
      @project.created_at = 6.hours.from_now
      @project.should_not be_valid
    end
  end
  

end
