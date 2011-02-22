class CreateStatics < ActiveRecord::Migration
  def self.up
    create_table :statics do |t|
      t.string :name
      t.text :text_nl
      t.text :text_en
      t.text :text_fr

      t.timestamps
    end
  end

  def self.down
    drop_table :statics
  end
end
