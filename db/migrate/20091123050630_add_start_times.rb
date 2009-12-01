class AddStartTimes < ActiveRecord::Migration
  def self.up
     add_column :assignments, :start_time, :datetime
     add_column :tasks, :start_time, :datetime
     add_column :projects, :start_time, :datetime
  end

  def self.down
     remove_column :assignments, :start_time
     remove_column :tasks, :start_time
     remove_column :projects, :start_time
  end
end
