class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :task


  def complete
    self.completed_at = Time.now
  end

  def drop
    self.completed_at = nil
    self.user = nil
  end

  def uncomplete
    self.completed_at = nil
  end




  def is_complete?
    self.completed_at.present?
  end

end
