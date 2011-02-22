class AddOldIdToPeriodicalLanguage < ActiveRecord::Migration
  def self.up
    add_column :periodical_languages, :old_id, :integer
  end

  def self.down
    remove_column :periodical_languages, :old_id
  end
end
