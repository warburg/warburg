class ShowDateToDateIsaar < ActiveRecord::Migration
  def self.up
    rename_column :shows, :date, :old_date
    add_column :shows, :date_id, :integer
    
    Show.find_each do |show|
      if show.old_date
        show.date = DateIsaar.create_from_date(show.old_date)
        show.save
      end
    end
  end

  def self.down
    rename_column :shows, :old_date, :date
    remove_column :shows, :date_id
  end
end
