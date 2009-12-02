require 'spec_helper'

describe Task do
    fixtures :users, :projects, :tasks

  before(:each) do
    @users = users(:quentin)
    @project = projects(:projectn)
    @valid_attributes = {
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
  
  describe "Given it has valid attributes" do
    it "should belong to a project"
    it "should have a valid description"
    it "should have a valid name"
    it "should have a valid due by date"
  end
  
end
