class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  validates_presence_of :task


  def validate
    if start_time > due_by
      errors.add("Start time", "must be before due date")
    end
  end
  
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

  private
    def validate
      errors.add("due_by", "cannot be before now") unless self.due_by > self.created_at
      errors.add("due_by", "cannot be before start time") unless self.due_by > self.start_time
    end
  
end
