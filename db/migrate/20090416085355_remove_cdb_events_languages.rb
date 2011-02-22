class RemoveCdbEventsLanguages < ActiveRecord::Migration
  def self.up
    drop_table :cdb_events_languages
  end

  def self.down
    create_table "cdb_events_languages", :force => true do |t|
      t.integer "cdb_event_id"
      t.integer "language_id"
    end
    
  end
end
