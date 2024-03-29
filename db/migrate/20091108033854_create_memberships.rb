class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
      t.references :user
      t.references :project
      t.integer :privilege

      t.timestamps
    end
  end

  def self.down
    drop_table :memberships
  end
end
