class CreateCdbContactinfos < ActiveRecord::Migration
  def self.up
    create_table :cdb_contactinfos do |t|
      t.integer :cdb_actor_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cdb_contactinfos
  end
end
