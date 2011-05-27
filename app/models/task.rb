class Task < ActiveRecord::Base
  belongs_to :project
  has_many :assignments, :dependent => :destroy
  has_many :dependencies
  has_many :prerequisites, :through => :dependencies
  belongs_to  :manager, :class_name => "User"

  validates_presence_of :name, :desc, :manager_id
  
  def validate
    errors.add("Start time", "must be before due date") unless (due_by != nil and start_time != nil and self.start_time < self.due_by)
    errors.add("Due by", "must be after now") unless (due_by != nil and ((created_at == nil and Time.now <= self.due_by) or (created_at != nil and created_at <= self.due_by)))
    errors.add("Due by", "must be before project due by") unless (due_by != nil and project != nil and project.due_by != nil and project.due_by >= self.due_by)
  end

  def complete
    self.completed_at = Time.now
  end

  def uncomplete
    self.completed_at = nil
  end

  def is_complete?
    self.completed_at.present?
  end
  
  def cleared_prerequisites?
    prereqs = self.prerequisites
    prereqs.each do |prereq|
      if prereq.completed_at.blank?
        return false
      end
    end
    return true
  end
  
  def can_depend_on?(task)
    prereqs = self.prerequisites
    if self == task
      return false
    elsif self.depends_on?(task)
      return false
    else
      task.prerequisites.each do |prereq|
        if task.depends_on?(self)
          return false
        end
      end
      return true
    end
  end
  
  def depends_on?(task)
    if self.prerequisites.include?(task)
      return true
    else
      self.prerequisites.each do |prereq|
        if prereq.depends_on?(task)
          return true
        end
      end
      return false
    end
  end


end
