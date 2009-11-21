class Task < ActiveRecord::Base
  belongs_to :project
  has_many :assignments, :dependent => :destroy
end
