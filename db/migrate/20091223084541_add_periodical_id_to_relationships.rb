class AddPeriodicalIdToRelationships < ActiveRecord::Migration
  def self.up
    add_column :relationships, :periodical_id, :integer
  end

  def self.down
    remove_column :relationships, :periodical_id
  end
end
