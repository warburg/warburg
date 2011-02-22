class RenameRevivalToRerun < ActiveRecord::Migration
  def self.up
    rename_column :productions, :revival_of_id, :rerun_of_id
    rename_column :production_versions, :revival_of_id, :rerun_of_id
  end

  def self.down
    rename_column :production_versions, :rerun_of_id, :revival_of_id
    rename_column :productions, :rerun_of_id, :revival_of_id
  end
end
