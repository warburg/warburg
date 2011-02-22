class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      # DONE:
      # AVDoorOrganisties, AVDoorPersonen, AVOverOrganisaties, AVOverPersonen, 
      # AVOverProducties, ArchiefBestanddelenOverOrganisaties
      t.references(:audio_video_title)
      t.references(:organisation)
      t.references(:person)
      t.references(:production)
      t.references(:archive_part)
      
      t.string(:function_colophon)
      t.string(:type)
      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :relationships
  end
end
