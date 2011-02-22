class CreateProperties < ActiveRecord::Migration
  def self.up
    create_table :properties do |t|
      t.string :property
      t.string :description_dutch

      t.timestamps
    end
  end

  def self.down
    drop_table :organisation_property
  end
end
