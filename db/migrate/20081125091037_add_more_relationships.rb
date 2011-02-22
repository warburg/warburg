class AddMoreRelationships < ActiveRecord::Migration
  def self.up    
    # DONE: ArchiefBestanddelenOverPersonen, ArchiefBestanddelenOverProducties
    # ArtikelsDoorOrganisaties, ArtikelsDoorPersonen, ArtikelsOverOrganisaties, 
    # ArtikelsOverPersonen
    # ArtikelsOverProducties
    # BoekTitelDoorOrganisaties, BoekTitelDoorPersonen, BoekTitelOverOrganisaties,
    # BoekTitelOverPersonen, BoekTitelOverProducties
    change_table :relationships do |t|
      t.references(:article)
      t.references(:function)
      t.references(:book_title)
      t.integer(:index)
      t.rename(:function_colophon, :function_text)
    end
  end

  def self.down
    change_table :relationships do |t|
      t.remove_references(:article)
      t.remove_references(:function)
      t.remove_references(:book_title)
      t.remove(:index)
      t.rename(:function_text, :function_colophon)
    end
  end
end