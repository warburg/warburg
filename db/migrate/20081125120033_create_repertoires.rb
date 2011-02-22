class CreateRepertoires < ActiveRecord::Migration
  def self.up
    create_table :repertoires do |t|
      t.string :title
      t.string :inspiration_sources
      t.date :creation_date
      t.integer :number_of_roles
      t.integer :female_roles
      t.integer :male_roles
      t.integer :child_roles
      t.string :note

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :repertoires
  end
end
