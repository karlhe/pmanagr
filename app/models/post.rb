class Post < ActiveRecord::Base
  belongs_to :discussion
  belongs_to :user


  attr_accessible :user_id, :discussion_id, :content

  def author
    self.user
  end

  def author=(value)
    write_attribute :user_id, value.id
  end

  

end
