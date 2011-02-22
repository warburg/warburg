class AddBarcodes < ActiveRecord::Migration
  def self.up
    rename_column :book_copies, :copy_id, :barcode
    rename_column :periodical_issues, :issue_id, :barcode
    rename_column :warehouses, :box_id, :barcode
    
    change_column :book_copies, :barcode, :string
    change_column :periodical_issues, :barcode, :string
    change_column :warehouses, :barcode, :string
  end

  def self.down
    change_column :book_copies, :barcode, :integer
    change_column :periodical_issues, :barcode, :integer
    change_column :warehouses, :barcode, :integer

    rename_column :warehouses, :barcode, :box_id
    rename_column :periodical_issues, :barcode, :issue_id
    rename_column :book_copies, :barcode, :copy_id
  end
end
