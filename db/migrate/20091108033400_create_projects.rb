class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.text :desc
      t.boolean :public
      t.datetime :due_by
      t.datetime :completed_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
