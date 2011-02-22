class MakeGrantStateMultilingual < ActiveRecord::Migration
  def self.up
    rename_column :grant_states, :description, :description_nl
    add_column :grant_states, :description_fr, :string
    add_column :grant_states, :description_en, :string
  end

  def self.down
    remove_column :grant_states, :description_en
    remove_column :grant_states, :description_fr
    rename_column :grant_states, :description_nl, :description
  end
end
