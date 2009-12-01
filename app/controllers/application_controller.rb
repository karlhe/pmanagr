# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  include AuthenticatedSystem
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  private
  
  def check_public_access
    private = !Project.find(params[:id]).is_public?
    if (!logged_in? and private)  || (logged_in? and private and (!current_user.memberships.select{|m| m.project_id.to_s == params[:id]}.first))
      redirect_to root_path
      flash[:error] = 'You do not have permission to view this private project.'
    end
  end

  def check_admin
    project_admin = Project.find(params[:id]).admin
    #assignment_admin = Assignment.find(params[:assignment_id]).admin
    if (project_admin != current_user)
      redirect_to root_path
      flash[:error] = 'You do not have permission to destroy this project.'
    end
  end
 
end