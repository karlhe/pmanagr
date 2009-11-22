class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # include AuthenticatedSystem
  
  def show
    @user = current_user
    @assignments = @user.assignments
    @late_assignments = @assignments.select{|assignment| assignment.due_by > Time.now}
    @upcoming_assignments = @assignments.select{|assignment| assignment.due_by <= Time.now and assignment.due_by < 14.days.since}
    @recent_activity = @assignments.select{|assignment| assignment.updated_at > 14.days.ago}
  end
  
  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
end
