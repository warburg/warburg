class CreateOrganisations < ActiveRecord::Migration
  def self.up
    create_table :organisations do |t|
      t.string :name
      t.integer :legal_form_id
      t.integer :grant_status_id
      t.integer :organisation_type_id
      t.integer :language_id
      t.string :url
      t.integer :publicid

      t.timestamps
    end
  end

  def self.down
    drop_table :organisations
  end
end
