class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  attr_accessible :privilege


  def set_permission(perm)
    if (perm == "owner")
      self.privilege = 1
    elsif (perm == "user")
      self.privilege = 2
    end
  end



  def is_admin?
    self.privilege == 1
  end

  def is_user?
    self.privilege == 2
  end


end