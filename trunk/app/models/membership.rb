class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates_presence_of :project, :user, :privilege


  def set_permission(perm)
    if (perm == "owner")
      self.privilege = 1
    elsif (perm == "user")
      self.privilege = 2
    elsif (perm == "pending")
      self.privilege = 3
    elsif (perm == "request")
      self.privilege = 4
    end
  end
  
  def self.permission(perm)
    if (perm == "owner")
      return 1
    elsif (perm == "user")
      return 2
    elsif (perm == "pending")
      return 3
    elsif (perm == "request")
      return 4
    end
  end

  def level
    if self.privilege == 1
      return "owner"
    elsif self.privilege == 2
      return "user"
    elsif self.privilege == 3
      return "pending"
    elsif self.privilege == 4
      return "request"
    else
      return "unknown"
    end
  end


  def is_owner?
    self.privilege == 1
  end

  def is_user?
    self.privilege == 2
  end

  def is_approved?
    self.privilege == 2 or self.privilege == 1
  end

  def is_pending?
    self.privilege == 3
  end
  
  def is_request?
    self.privilege == 4
  end

end
