class ContinueMoreRelationships < ActiveRecord::Migration
  def self.up
    # TODO: AVOverTrefwoorden, ArtikelsOverTrefwoord, BoekTitelOverTrefwoord, DocuOverTrefwoorden, 
    # IcoOverTrefwoorden, TrefwoordenBijTijdschrift, VerwervingOverTrefwoorden
    
    # DONE: OrganisatiesBijRuimtes, RepertoireTalen, BestellingenBoeken
    change_table :relationships do |t|
      t.references(:room)
      t.references(:language)
      t.references(:order)
      t.string(:language_note)
      t.datetime(:delivery_date)
      t.text(:note)
    end    
  end

  def self.down
    change_table :relationships do |t|
      t.remove_references(:room)
      t.remove_references(:language)
      t.remove_references(:order)
      t.remove(:language_note)
      t.remove(:delivery_date)
      t.remove(:note)
    end    
  end
end
