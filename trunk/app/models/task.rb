class Task < ActiveRecord::Base
  belongs_to :project
  has_many :assignments, :dependent => :destroy

  validates_presence_of :name, :desc
end
