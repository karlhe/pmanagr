class Dependency < ActiveRecord::Base
  has_many :tasks
  has_many :prerequisites, :class_name => 'Task'
end
