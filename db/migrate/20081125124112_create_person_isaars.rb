class CreatePersonIsaars < ActiveRecord::Migration
  def self.up
    create_table :person_isaars do |t|
      t.integer :person_id
      t.string :key_name
      t.integer :alias_of_id
      t.integer :country_id
      t.string :description, :limit => 350
      t.string :note

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :person_isaars
  end
end
