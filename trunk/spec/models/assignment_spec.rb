require 'spec_helper'

describe Assignment do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    Assignment.create!(@valid_attributes)
  end
end