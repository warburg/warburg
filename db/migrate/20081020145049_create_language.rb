class CreateLanguage < ActiveRecord::Migration
  def self.up
    create_table :languages, :force => true do |t|
      t.string :iso_code, :limit => 3
      t.string :english
      t.string :dutch
      t.string :french
      t.timestamps
    end
  end

  def self.down
    drop_table :languages
  end
end
