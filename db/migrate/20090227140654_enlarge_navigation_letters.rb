class EnlargeNavigationLetters < ActiveRecord::Migration
  def self.up
    change_column :navigation_letters, :letters, :string, :limit => 10000
  end

  def self.down
    change_column :navigation_letters, :letters, :string, :limit => 5000
  end
end
