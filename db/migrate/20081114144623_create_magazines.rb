class CreateMagazines < ActiveRecord::Migration
  def self.up
    create_table :magazines do |t|
      t.string :antilope_index
      t.string :title
      t.string :title_extra
      t.string :description
      t.string :issn
      t.string :magazine_note
      t.string :cardex
      t.string :holdings
      t.string :subscription_type
      t.string :subscription_periodicity
      t.boolean :subscription_running
      t.date :subscription_end_date
      t.string :subscription_note
      t.integer :organisation_id
      t.integer :ranking

      t.timestamps
    end
  end

  def self.down
    drop_table :magazines
  end
end
