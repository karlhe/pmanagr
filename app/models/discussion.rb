class Discussion < ActiveRecord::Base
  belongs_to :project
  has_many :posts
end
