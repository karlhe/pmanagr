class Dependency < ActiveRecord::Base
  belongs_to :task
  belongs_to :prerequisite, :class_name => 'Task'
end
