class CreateLanguageRole < ActiveRecord::Migration
  def self.up
    create_table :language_roles do |t|
      t.string :description_nl
      t.string :description_en
      t.string :description_fr

      t.timestamps
      t.userstamps
    end

    add_column :audio_video_languages, :language_role_id, :integer

    remove_column :postits, :audio_video_language_id

    add_column :statics, :creator_id, :integer
    add_column :statics, :updater_id, :integer

  end

  def self.down
    remove_column :audio_video_languages, :language_role_id
    drop_table :language_roles
    remove_column :statics, :creator_id
    remove_column :statics, :updater_id
    add_column :postits, :audio_video_language_id, :integer
  end
end
