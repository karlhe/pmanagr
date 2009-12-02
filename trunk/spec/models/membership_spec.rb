require 'spec_helper'

describe Membership do
  fixtures :users, :projects, :memberships

  before(:each) do
    @project = projects(:projectn)
    @user = users(:quentin)
    @membership = memberships(:one)
    @valid_attributes = {
        :user_id => 1,
        :task_id => 1,
        :privilege => 2
    }
  end

  it "should create a new instance given valid attributes" do
    Membership.create!(@valid_attributes)
  end
  
  describe "Given valid attributes" do
    it "should have a user" do
      @membership.user.should == @user
    end
    it "should have a project" do
      @membership.project.should == @project
    end
    it "should have a privilege level for the user in that project" do
      (1..4).should be_include @membership.privilege
    end
  end
  
end
