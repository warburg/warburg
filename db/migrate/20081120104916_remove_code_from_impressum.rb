class RemoveCodeFromImpressum < ActiveRecord::Migration
  def self.up
    remove_column :impressums, :code
  end

  def self.down
    add_column :impressums, :code, :string
  end
end
