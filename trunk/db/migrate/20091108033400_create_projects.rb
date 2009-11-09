class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.text :desc
      t.boolean :public
      t.datetime :due

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
