class CreateAcquisitions < ActiveRecord::Migration
  def self.up
    create_table :acquisitions do |t|
      t.string :code
      t.string :title
      t.date :acquisition_date
      t.string :ex_dono
      t.integer :person_id
      t.integer :organisation_id
      t.integer :donor_person_id
      t.integer :donor_organisation_id
      t.string :size
      t.string :content
      t.string :dating
      t.string :note

      t.timestamps
    end
  end

  def self.down
    drop_table :acquisitions
  end
end
