require 'spec_helper'

describe AssignmentsController do
  fixtures :users, :projects, :tasks, :assignments, :memberships

  describe "When assigning a task" do
    before :each do
      @current_user = users(:quentin)
      controller.stub!(:current_user).and_return(@current_user)
      controller.stub!(:login_required).and_return(:true)
      @task = tasks(:one)
      @project = projects(:projectn)
      @assignment = assignments(:one)
      @memberships = memberships(:one)
    end
    describe "When assigning yourself an assignment" do
      it "should set the current user as a user for the assignment" do
        Assignment.stub!(:new).and_return @assignment
        @assignment.stub!(:memberships).and_return @memberships
        controller.stub!(:params).and_return(:project_id => "1", :task_id => "1")
        post :take
        @assignment.user_id == @current_user.id
      end
      it "should add the assignment to the user's assignments" do
        Assignment.stub!(:new).and_return @assignment
        @assignment.stub!(:memberships).and_return @memberships
        controller.stub!(:params).and_return(:project_id => "1", :task_id => "1")
        post :take
        @current_user.assignments.select{|x| x.id == 1}.size.should_not == 0
      end
      it "should redirect to the task page" do
        Assignment.stub!(:new).and_return @assignment
        @assignment.stub!(:memberships).and_return @memberships
        controller.stub!(:params).and_return(:project_id => "1", :task_id => "1")
        post :take
        response.should redirect_to(project_task_url(@project, @task))
      end
    end
    describe "When assigning someone else a task as an admin" do
      before :each do
        @current_user = users(:quentin)
        controller.stub!(:current_user).and_return(@current_user)
        controller.stub!(:login_required).and_return(:true)
        @user = users(:aaron)
        @task = tasks(:one)
        @project = projects(:projectn)
        @assignment = assignments(:two)
        @memberships = memberships(:two)
      end
      it "should set the target user as a user for the task" do
        Assignment.stub!(:new).and_return @assignment
        @assignment.stub!(:memberships).and_return @memberships
        controller.stub!(:params).and_return(:project_id => "1", :task_id => "1")
        Assignment.stub!(:find).and_return @user
        post :show
        @assignment.user_id.should == @user.id
      end
      it "should add the task to the target user's assignments" do
        Assignment.stub!(:new).and_return @assignment
        @assignment.stub!(:memberships).and_return @memberships
        controller.stub!(:params).and_return(:project_id => "1", :task_id => "1", :id => "2")
        post :show
        @user.assignments.select{|x| x.id == 2}.size.should_not == 0
      end
      it "should redirect to the task page" do
        Assignment.stub!(:new).and_return @assignment
        @assignment.stub!(:memberships).and_return @memberships
        controller.stub!(:params).and_return(:project_id => "1", :task_id => "1")
        post :show
        response.should redirect_to(project_task_url(@project, @task))
      end
    end
  end

  describe "When completing a task" do
    before :each do
      @current_user = users(:quentin)
      controller.stub!(:current_user).and_return(@current_user)
      controller.stub!(:login_required).and_return(:true)
      @assignment2 = assignments(:one)
      @memberships = memberships(:one)
    end
    it "should set the completed by time to the current time"
  end

end
