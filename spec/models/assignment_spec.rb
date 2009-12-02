require 'spec_helper'

describe Assignment do
  fixtures :users, :projects, :tasks
  
  before(:each) do
    @user = users(:quentin)
    @project = projects(:projectn)
    @task = tasks(:one)
    @valid_attributes = {
        :task => @task,
        :name => "Clean Room",
        :desc => "Momma told you to go clean your room.",
        :due_by => 5.hours.from_now,
        :created_at => Time.now,
        :start_time => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    Assignment.create!(@valid_attributes)
  end
 
  describe "Given valid attributes" do
    it "should have a task" do 
        @assignments = Assignment.create!(@valid_attributes)
        @assignments.task.should == @task
    end
    it "should have a start time earlier than its due date" do 
        @assignments = Assignment.create!(@valid_attributes)
        @assignments.due_by.should > @assignments.start_time
    end
    it "should have a created at time earlier than its due date" do 
        @assignments = Assignment.create!(@valid_attributes)
        @assignments.due_by.should > @assignments.created_at
    end
    it "should have a task due by later than its due date" do 
        @assignments = Assignment.create!(@valid_attributes)
        @assignments.task.due_by.should > @assignments.due_by
    end
  end
  
  describe "Given an assignment with a start time later than its due date" do
    it "should not be valid" do
        @start_late = {
            :task_id => 1,
            :name => "Clean Room",
            :desc => "Momma told you to go clean your room.",
            :due_by => 5.hours.from_now,
            :created_at => Time.now,
            :start_time => 6.hours.from_now
        }
        Assignment.new(@start_late).should_not be_valid
    end
  end
  
  describe "Given an assignment with a created at time later than it's due date" do
    it "should not be valid" do
        @create_late = {
            :task_id => 1,
            :name => "Clean Room",
            :desc => "Momma told you to go clean your room.",
            :due_by => 5.hours.from_now,
            :created_at => 6.hours.from_now,
            :start_time => Time.now
        }
        Assignment.new(@create_late).should_not be_valid
    end
  end
  
  describe "Given an assignment with a task due date later than it's due date" do
    it "should not be valid" do
        @task.due_by = 3.hours.from_now
        @task_late = {
            :task => @task,
            :name => "Clean Room",
            :desc => "Momma told you to go clean your room.",
            :due_by => 5.hours.from_now,
            :created_at => Time.now,
            :start_time => Time.now
        }
        Assignment.new(@task_late).should_not be_valid
    end
  end
  
end
 