class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :last_name
      t.string :first_name
      t.string :gender, :limit => 1
      t.integer :language_id
      t.integer :publicid

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
