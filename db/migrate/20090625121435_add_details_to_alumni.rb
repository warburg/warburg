class AddDetailsToAlumni < ActiveRecord::Migration
  def self.up
    add_column :alumni, :details, :string
  end

  def self.down
    remove_column :alumni, :details
  end
end
