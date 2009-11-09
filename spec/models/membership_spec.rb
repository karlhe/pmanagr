require 'spec_helper'

describe Membership do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    Membership.create!(@valid_attributes)
  end
  
  describe "Given valid attributes" do
    it "should have a user"
    it "should have a project"  
    it "should have a privilege level for the user in that project"
  end
  
end
