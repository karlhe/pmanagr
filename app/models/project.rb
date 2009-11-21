class Project < ActiveRecord::Base
  has_many :memberships
  has_many :users, :through => :memberships
  has_many :tasks, :dependent => :destroy
  has_many :threads, :dependent => :destroy
  
  validates_presence_of :name, :desc
end