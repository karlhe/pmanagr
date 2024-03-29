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
      errors.add("Start time", "must be before due date") unless (due_by != nil and start_time != nil and self.start_time < self.due_by)
      errors.add("Due by", "must be after now") unless (due_by != nil and ((created_at == nil and Time.now <= self.due_by) or (created_at != nil and created_at <= self.due_by)))
      errors.add("Due by", "must be before task due by") unless (due_by != nil and task != nil and task.due_by != nil and task.due_by >= self.due_by)
    end
  
end
