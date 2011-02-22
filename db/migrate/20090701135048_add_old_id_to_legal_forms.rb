class AddOldIdToLegalForms < ActiveRecord::Migration
  def self.up
    add_column :legal_forms, :old_id, :integer
  end

  def self.down
    remove_column :legal_forms, :old_id
  end
end
