class CreatePolymorphicPostitables < ActiveRecord::Migration
  def self.up
    add_column :postits, :postitable_id, :integer
    add_column :postits, :postitable_type, :string
  end

  def self.down
    remove_column :postits, :postitable_type
    remove_column :postits, :postitable_id
  end
end
