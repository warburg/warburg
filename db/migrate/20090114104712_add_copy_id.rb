class AddCopyId < ActiveRecord::Migration
  def self.up
    add_column(:periodical_copies, :copy_id, :integer)
    add_column(:book_copies, :copy_id, :integer)
    add_column(:warehouses, :box_id, :integer)
  end

  def self.down
    remove_column(:periodical_copies, :copy_id)
    remove_column(:book_copies, :copy_id)    
    remove_column(:warehouses, :box_id)    
  end
end
