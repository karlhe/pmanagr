class AddTaskManagers < ActiveRecord::Migration
  def self.up
    add_column :tasks, :manager_id, :integer
  end

  def self.down
    remove_column :tasks, :manager_id
  end
end
