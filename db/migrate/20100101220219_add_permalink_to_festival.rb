class AddPermalinkToFestival < ActiveRecord::Migration
  def self.up
    add_column :festivals, :permalink, :string
  end

  def self.down
    remove_column :festivals, :permalink
  end
end
