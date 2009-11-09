class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :task
  has_many :assignments
  has_many :users, :through => :assignments
end
