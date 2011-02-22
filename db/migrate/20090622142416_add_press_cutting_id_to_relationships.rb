class AddPressCuttingIdToRelationships < ActiveRecord::Migration
  def self.up
    change_table :relationships do |t|
      t.references(:press_cutting)
    end
  end

  def self.down
    change_table :relationships do |t|
      t.remove_references(:press_cutting)
    end
  end
end
