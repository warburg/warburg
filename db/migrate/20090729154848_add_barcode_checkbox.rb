class AddBarcodeCheckbox < ActiveRecord::Migration
  def self.up
    add_column :audio_video_media, :print_barcode, :boolean
    add_column :book_copies, :print_barcode, :boolean
    add_column :warehouses, :print_barcode, :boolean
    add_column :periodical_issues, :print_barcode, :boolean
  end

  def self.down
    remove_column :periodical_issues, :print_barcode
    remove_column :warehouses, :print_barcode
    remove_column :book_copies, :print_barcode
    remove_column :audio_video_media, :print_barcode
  end
end
