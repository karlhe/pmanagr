class AddStartTimes < ActiveRecord::Migration
  def self.up
     add_column :assignments, :start_time, :datetime
     add_column :tasks, :start_time, :datetime
     add_column :projects, :start_time, :datetime
  end

  def self.down
     drop_column :assignments, :start_time
     drop_column :tasks, :start_time
     drop_column :projects, :start_time
  end
end
