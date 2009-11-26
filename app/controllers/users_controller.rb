class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # include AuthenticatedSystem
  
  def show
    
    begin @user = User.find(params[:id])
    rescue Exception
      @user = current_user
    end

    @assignments = @user.assignments
    @late_assignments = @assignments.select{|assignment| assignment.due_by < Time.now}
    @upcoming_assignments = @assignments.select{|assignment| assignment.due_by >= Time.now and assignment.due_by < 7.days.since}
    @recent_activity = @assignments.select{|assignment| assignment.updated_at > 3.days.ago}
  end
  
  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @user.capitalize_name
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!"
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin."
      render :action => 'new'
    end
  end
end
