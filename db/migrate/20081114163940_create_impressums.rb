class CreateImpressums < ActiveRecord::Migration
  def self.up
    create_table :impressums do |t|
      t.string :code
      t.string :publisher
      t.string :publish_location
      t.string :note
      t.integer :organisation_id

      t.timestamps
    end
  end

  def self.down
    drop_table :impressums
  end
end
