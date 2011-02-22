class AddWarehouseToRelationships < ActiveRecord::Migration
  def self.up
    add_column :relationships, :warehouse_id, :integer
  end

  def self.down
    remove_column :relationships, :warehouse_id
  end
end
