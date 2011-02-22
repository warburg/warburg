class CreateDescriptions < ActiveRecord::Migration
  def self.up
    create_table :descriptions do |t|
      t.string  :description_nl
      t.string  :description_fr
      t.string  :description_en
      t.integer :creator_id
      t.integer :updater_id
      t.string  :cached_slug

      t.timestamps
    end
  end

  def self.down
    drop_table :descriptions
  end
end
