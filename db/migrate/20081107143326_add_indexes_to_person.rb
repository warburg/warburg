class AddIndexesToPerson < ActiveRecord::Migration
  def self.up
    add_index :people, :permalink
  end

  def self.down
    remove_index :people, :permalink
  end
end
