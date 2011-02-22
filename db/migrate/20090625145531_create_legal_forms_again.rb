class CreateLegalFormsAgain < ActiveRecord::Migration
  def self.up
    create_table :legal_forms, :force => true do |t|
      t.string :name_nl
      t.string :name_fr
      t.string :name_en
      
      t.userstamps
      t.timestamps
    end
    
    add_column :organisations, :legal_form_id, :integer
  end

  def self.down
    remove_column :organisations, :legal_form_id
    drop_table :legal_forms
  end
end
