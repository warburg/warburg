class RemoveExactDateFromDateIsaar < ActiveRecord::Migration
  def self.up
    remove_column :date_isaars, :exact_date
  end

  def self.down
    add_column :date_isaars, :exact_date, :string
  end
end
