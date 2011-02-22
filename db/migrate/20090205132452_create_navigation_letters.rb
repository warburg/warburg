class CreateNavigationLetters < ActiveRecord::Migration
  def self.up
    create_table :navigation_letters do |t|
      t.string :classname
      t.string :letters, :limit => 5000
    end
  end

  def self.down
    drop_table :navigation_letters
  end
end
