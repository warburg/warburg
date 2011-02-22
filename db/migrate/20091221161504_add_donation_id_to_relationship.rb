class AddDonationIdToRelationship < ActiveRecord::Migration
  def self.up
    add_column :relationships, :donation_id, :integer
  end

  def self.down
    remove_column :relationships, :donation_id
  end
end
