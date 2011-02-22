class ShowRemoveOldDate < ActiveRecord::Migration
  def self.up
    remove_column :shows, :old_date
  end

  def self.down
    add_column :shows, :old_date, :date
  end
end
