class CreateAudioVideoMedia < ActiveRecord::Migration
  def self.up
    create_table :audio_video_media do |t|
      t.integer :audio_video_medium_type_id
      t.date :date
      t.integer :copy_of_id
      t.integer :donation_id
      t.string :library_location
      t.integer :warehouse_id
      t.boolean :available
      t.string :technical_note
      t.string :general_note

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :audio_video_media
  end
end
