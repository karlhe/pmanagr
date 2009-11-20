class Thread < ActiveRecord::Base
  has_many :posts, :dependent => :destroy
  belongs_to :project
end
