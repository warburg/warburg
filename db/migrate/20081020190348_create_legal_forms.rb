class CreateLegalForms < ActiveRecord::Migration
  def self.up
    create_table :legal_forms do |t|
      t.string :dutch

      t.timestamps
    end
  end

  def self.down
    drop_table :legal_forms
  end
end
