class Project < ActiveRecord::Base
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  has_many :tasks, :dependent => :destroy
  has_many :discussions, :dependent => :destroy
  
  validates_presence_of :name, :desc

  attr_accessible :start_time, :name, :desc, :due_by
  
  def is_public?
    return public
  end

  def is_owner? user
    @membership = user.memberships.find(:all, :conditions => {:user => user, :project => this})
    if @membership == []
      return false
    else
      return @member.is_owner?
    end
  end

  def is_member? user
    #Not finished
    @membership = user.memberships.find(:all, :conditions => {:user => user, :project => this})
    return @member.is_owner?
  end
end
