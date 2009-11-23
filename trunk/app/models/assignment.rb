class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  def complete
    self.completed_at = Time.now
  end
end
