class AddTitleNlToCdbEvent < ActiveRecord::Migration
  def self.up
    add_column :cdb_events, :title_nl, :string
  end

  def self.down
    remove_column :cdb_events, :title_nl
  end
end
