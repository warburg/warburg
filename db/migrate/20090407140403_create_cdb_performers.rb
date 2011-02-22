class CreateCdbPerformers < ActiveRecord::Migration
  def self.up
    create_table :cdb_performers do |t|
      t.string :role
      t.integer :cdb_actor_id
      t.string :label

      t.timestamps
    end
  end

  def self.down
    drop_table :cdb_performers
  end
end
