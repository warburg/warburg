class CreatePeriodicalImpressums < ActiveRecord::Migration
  def self.up
    create_table :periodical_impressums do |t|
      t.integer :impressum_id
      t.integer :periodical_id
      t.integer :creator_id
      t.integer :updater_id

      t.timestamps
    end
  end

  def self.down
    drop_table :periodical_impressums
  end
end
