class AddHasRegisteredFieldToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :has_registered, :boolean, :default => true
  end

  def self.down
    drop_column :users, :has_registered
  end
end
