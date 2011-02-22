class CreateCdbActorDetails < ActiveRecord::Migration
  def self.up
    create_table :cdb_actor_details do |t|
      t.integer :cdb_actor_id
      t.integer :language_id
      t.text :longdescription
      t.string :shortdescription, :limit => 600
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :cdb_actor_details
  end
end
