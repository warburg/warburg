class CreateAudioVideoTitles < ActiveRecord::Migration
  def self.up
    create_table :audio_video_titles do |t|
      t.string :title
      t.string :description
      t.date :creation_date
      t.integer :creation_year
      t.integer :creation_month
      t.string :creation_date_text
      t.integer :duration_minutes
      t.string :copyright
      t.string :note, :limit => 600

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :audio_video_titles
  end
end
