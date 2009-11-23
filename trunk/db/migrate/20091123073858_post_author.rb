class PostAuthor < ActiveRecord::Migration
  def self.up
     add_column :posts, :author, :user
  end

  def self.down
     drop_column :posts, :author
  end
end
