class Project < ActiveRecord::Base
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  has_many :tasks, :dependent => :destroy
  has_many :discussions, :dependent => :destroy
  
  validates_presence_of :name, :desc
end
