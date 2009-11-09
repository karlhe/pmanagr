require 'spec_helper'

describe Task do
  before(:each) do
    @valid_attributes = {
      
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
