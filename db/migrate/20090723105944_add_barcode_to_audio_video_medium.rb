class AddBarcodeToAudioVideoMedium < ActiveRecord::Migration
  def self.up
    add_column :audio_video_media, :barcode, :string
  end

  def self.down
    remove_column :audio_video_media, :barcode
  end
end
