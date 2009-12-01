class MembershipsController < ApplicationController
  before_filter :login_required
  before_filter :check_public_access
  before_filter :check_admin, :except => :update
  
  def index
    @project = Project.find(params[:project_id])
    @memberships = @project.memberships
  end

  def new
    @project = Project.find(params[:project_id])
    @users = User.all.select { |user| not @project.users.include?(user) }
  end

  def create
    @project = Project.find(params[:project_id])
    
    @membership = Membership.new
    @membership.project = @project
    @membership.user_id = params[:user_id]
    @membership.set_permission("pending")
    
    if @membership.save
      flash[:notice] = "Member added to project."
      redirect_to new_project_membership_path(@project)
    else
      flash[:error] = "Could not add member."
      @users = User.all.select { |user| not @project.users.include?(user) }
      render :action => "new"
    end
  end
  
  def update
    @project = Project.find(params[:project_id])
    @membership = @project.memberships.find(params[:id])
    if @membership.level == "pending" and params[:accept] and current_user == @membership.user
      if @membership.update_attribute(:privilege, Membership.permission("user"))
        flash[:notice] = "Project invitation accepted!"
        redirect_to dashboard_path
      else
        flash[:error] = "Failed to accept invite."
      end
    elsif @project.update_attributes(params[:project])
      flash[:notice] = "Membership updated"
      redirect_to project_memberships_path(@project)
    else
      flash[:error] = "Failed to update membership."
      redirect_to project_memberships_path(@project)
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @membership = @project.memberships.find(params[:id])
    
    if @membership.is_owner?
      flash[:error] = "Cannot remove membership for owner."
      redirect_to project_memberships_path(@project)
    elsif @membership.destroy
      flash[:notice] = "User removed from project."
      redirect_to project_memberships_path(@project)
    else
      flash[:error] = "Could not remove user."
      redirect_to project_memberships_path(@project)
    end
  end
  
  private
    def check_public_access
      private = !Project.find(params[:project_id]).is_public?
      if (!logged_in? and private)  || (logged_in? and private and (!current_user.memberships.select{|m| m.project_id.to_s == params[:id]}.first))
        redirect_to root_path
        flash[:error] = 'You do not have permission to view this private project.'
      end
    end
  
    def check_admin
	    status = current_user.memberships.select{|m| m.project_id.to_s == params[:project_id]}.first
	    unless !status.blank? and status.is_owner?
        redirect_to root_path
        flash[:error] = 'You are not an admin for this project.'
      end
    end
    
end
