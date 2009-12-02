class Project < ActiveRecord::Base
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  has_many :tasks, :dependent => :destroy
  has_many :discussions, :dependent => :destroy
  
  attr_accessible :name, :desc, :public, :due_by, :start_time, :created_at
  
  validates_presence_of :name, :desc, :due_by, :start_time

  def validate
    errors.add("Public", "cannot be nil") unless public != nil
    errors.add("Start time", "must be before due date") unless (due_by != nil and start_time != nil and self.start_time < self.due_by)
    errors.add("Due by", "must be after now") unless (due_by != nil and ((created_at == nil and Time.now < self.due_by) or (created_at != nil and created_at < self.due_by)))
  end
  
  def is_public?
    return public
  end

  def is_owner? user
    membership = user.memberships.find(:all, :conditions => {:user => user, :project => this})
    if membership == []
      return false
    else
      return member.is_owner?
    end
  end

  def is_member? user
    #Not finished
    membership = user.memberships.find(:all, :conditions => {:user => user, :project => this})
    return member.is_owner?
  end

  def admin
    ms = self.memberships.detect {|m| m.is_owner?}
    return (ms ? ms.user : nil)
  end
end
