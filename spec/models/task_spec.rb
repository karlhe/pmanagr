require 'spec_helper'

describe Task do
    fixtures :users, :projects, :tasks

  before(:each) do
    @users = users(:quentin)
    @project = projects(:projectn)
    @project.due_by = 6.years.from_now
    @valid_attributes = {
        :id => 1,
        :project => @project,
        :name => "Travel the World",
        :desc => "Amazing Gulliver's Travels!",
        :due_by => 5.years.from_now,
        :created_at => 5.years.ago,
        :start_time => 5.years.ago
    }
  end

  it "should create a new instance given valid attributes" do
    Task.create!(@valid_attributes)
  end
  
  describe "Given valid attributes" do
    it "should have a project" do 
        @task = Task.create!(@valid_attributes)
        @Task.project.should == @project
    end
    it "should have a start time earlier than its due date" do 
        @task = Task.create!(@valid_attributes)
        @task.due_by.should > @task.start_time
    end
    it "should have a created at time earlier than its due date" do 
        @task = Task.create!(@valid_attributes)
        @task.due_by.should > @task.created_at
    end
    it "should have a task due by later than its due date" do 
        @task = Task.create!(@valid_attributes)
        @task.project.due_by.should > @task.due_by
    end
  end
  
  describe "Given an task with a start time later than its due date" do
    it "should not be valid" do
        @start_late = {
            :project => @project,
            :name => "Travel the World",
            :desc => "Amazing Gulliver's Travels!",
            :due_by => 5.years.from_now,
            :created_at => 5.years.ago,
            :start_time => 6.years.from_now
        }
        Assignment.new(@start_late).should_not be_valid
    end
  end
  
  describe "Given an task with a created at time later than it's due date" do
    it "should not be valid" do
        @create_late = {
            :project => @project,
            :name => "Travel the World",
            :desc => "Amazing Gulliver's Travels!",
            :due_by => 5.years.from_now,
            :created_at => 6.years.from_now,
            :start_time => 5.years.ago
        }
        Assignment.new(@create_late).should_not be_valid
    end
  end
  
  describe "Given an task with a project due date later than it's due date" do
    it "should not be valid" do
        @project.due_by = 4.years.from_now
        @project_late  = {
            :project => @project,
            :name => "Travel the World",
            :desc => "Amazing Gulliver's Travels!",
            :due_by => 5.years.from_now,
            :created_at => 5.years.ago,
            :start_time => 5.years.ago
        }
        Assignment.new(@project_late).should_not be_valid
    end
  end
  
end
