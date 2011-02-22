class ContinueAddingMoreRelationships < ActiveRecord::Migration
  def self.up
    # DONE: DocuDoorOrganisaties, DocuDoorPersonen, DocuOverOrganisaties, DocuOverPersonen,
    # DocuOverProducties, IcoDoorOrganisaties, IcoDoorPersonen, IcoOverOrganisaties, 
    # IcoOverPersonen, IcoOverProducties, ProductiesDoorOrganisaties, ProductiesDoorPersonen,
    # ProductiesOverGenres, ProductiesOverRepertoire, RepertoireDoorPersonen
    change_table :relationships do |t|
      t.references(:ephemerum)
      t.references(:ico_title)
      t.references(:production_genre)
      t.references(:repertoire)
      t.boolean(:reference)
      t.string(:role_info)
      t.string(:reference_type)
    end
  end

  def self.down
    change_table :relationships do |t|
      t.remove_references(:ephemerum)
      t.remove_references(:ico_title)
      t.remove_references(:production_genre)
      t.remove_references(:repertoire)
      t.remove(:reference)
      t.remove(:role_info)
      t.remove(:reference_type)
    end    
  end
end
