class LinkPostDiscussion < ActiveRecord::Migration
  def self.up
    add_column :posts, :discussion_id, :discussion
  end

  def self.down
    drop_column :posts, :discussion_id
  end
end
