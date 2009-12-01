require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :memberships
  has_many :projects, :through => :memberships
  has_many :assignments
  has_many :tasks, :through => :assignments
  has_many :posts
  
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_presence_of     :name
  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  

  attr_accessible :login, :email, :name, :password, :password_confirmation, :public



  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  def capitalize_name
     self.name = self.name.split(' ').map {|w| w.capitalize }.join(' ')
  end

  def is_public?
    return public
  end

  
  def is_owner?(project)
    membership = project.memberships.find(self)
    !membership.blank? and membership.is_owner?
  end

  def is_user?(project)
    membership = Membership.find(:first, :conditions => [:user => self, :project => project])
    !membership.blank? and self.is_owner?
  end

  def is_approved?(project)
    membership = Membership.find(:first, :conditions => [:user => self, :project => project])
    !membership.blank? and self.is_approved?
  end

  def is_pending?(project)
    membership = Membership.find(:first, :conditions => [:user => self, :project => project])
    !membership.blank? and self.is_pending?
  end
  
  def is_request?(project)
    membership = Membership.find(:first, :conditions => [:user => self, :project => project])
    !membership.blank? and self.is_request?
  end
	
  

end
