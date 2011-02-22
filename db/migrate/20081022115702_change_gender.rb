class ChangeGender < ActiveRecord::Migration
  def self.up
    create_table :genders, :force => true do |t|
      t.string :code, :limit => 1
    end

    remove_column :people, :gender
    add_column :people, :gender_id, :integer
  end

  def self.down
    drop_table :genders
    remove_column :people, :gender_id
    add_column :people, :gender, :string,      :limit => 1
  end
end
