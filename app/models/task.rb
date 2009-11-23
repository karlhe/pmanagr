class Task < ActiveRecord::Base
  belongs_to :project
  has_many :assignments, :dependent => :destroy

  validates_presence_of :name, :desc

  def complete
    self.completed_at = Time.now
  end

  def uncomplete
    self.completed_at = nil
  end


  def is_complete?
    self.completed_at.present?
  end

end
