class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.string :name
      t.string :address
      t.string :postal_code
      t.string :city
      t.integer :country_id
      t.boolean :temporary_location
      t.boolean :address_manager
      t.string :phone
      t.string :fax
      t.string :default_start_hour
      t.string :email
      t.string :url
      t.string :note

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :rooms
  end
end
