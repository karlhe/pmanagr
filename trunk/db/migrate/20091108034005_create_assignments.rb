class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.references :user
      t.references :task
      t.string :name
      t.text :desc
      t.datetime :due_by
      t.datetime :completed_at
      t.integer :hours_spent
      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
end
