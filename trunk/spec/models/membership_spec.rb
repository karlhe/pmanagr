require 'spec_helper'

describe Membership do
  fixtures :users, :projects

  before(:each) do
    @project = projects(:projectn)
    @user = users(:quentin)
    @valid_attributes = {
      :user => @user,
      :project => @project,
      :privilege => 0
    }
  end

  it "should create a new instance given valid attributes" do
    Membership.create!(@valid_attributes)
  end
  
  describe "Given valid attributes" do
    it "should have a user" do
      @membership = Membership.create!(@valid_attributes)
      @membership.user.should_not == nil
      @membership.user.should == @user
    end
    it "should have a project" do
      @membership = Membership.create!(@valid_attributes)
      @membership.project.should_not == nil
      @membership.project.should == @project
    end
    it "should have a privilege level for the user in that project" do
      @membership = Membership.create!(@valid_attributes)
      @membership.privilege.should_not == nil
      @membership.privilege.should == 0
    end
  end
  
end
