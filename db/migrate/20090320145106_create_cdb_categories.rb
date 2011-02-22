class CreateCdbCategories < ActiveRecord::Migration
  def self.up
    create_table :cdb_categories do |t|
      t.string :catid
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :cdb_categories
  end
end
