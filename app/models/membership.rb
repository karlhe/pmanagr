class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  attr_accessible :privilege


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
