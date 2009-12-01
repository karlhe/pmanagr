class Dependency < ActiveRecord::Base
  belongs_to :task
  belongs_to :prerequisite, :class_name => 'Task'
  
  protected
    def validate
      if not task.can_depend_on?(prerequisite)
        errors.add("prerequisite_id", "cannot be depended on")
      end
    end
end
