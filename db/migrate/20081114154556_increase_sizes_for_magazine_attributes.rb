class IncreaseSizesForMagazineAttributes < ActiveRecord::Migration
  def self.up
    change_column :magazines, :title_extra, :string, :limit => 500
    change_column :magazines, :magazine_note, :string, :limit => 500
    change_column :magazines, :description, :string, :limit => 1000
  end

  def self.down
    change_column :magazines, :description, :string, :limit => 255
    change_column :magazines, :magazine_note, :string, :limit => 255
    change_column :magazines, :title_extra, :string, :limit => 255
  end
end
