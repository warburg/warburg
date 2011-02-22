class AddUserStampsToPostits < ActiveRecord::Migration
  def self.up
    add_column :postits, :creator_id, :integer
    add_column :postits, :updater_id, :integer
  end

  def self.down
    remove_column :postits, :creator_id
    remove_column :postits, :updater_id
  end
end
