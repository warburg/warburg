class AddCodeToImpressums < ActiveRecord::Migration
  def self.up
    add_column :impressums, :code, :string
  end

  def self.down
    remove_column :impressums, :code
  end
end
