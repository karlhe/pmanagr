class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.references :project
      t.references :task
      t.string :name
      t.text :desc
      t.datetime :due_by
      t.datetime :completed_at

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
