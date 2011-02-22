class AddMultiLanguageToTargetAudienceText < ActiveRecord::Migration
  def self.up
    rename_column :productions, :target_audience_text, :target_audience_text_nl
    add_column :productions, :target_audience_text_fr, :string
    add_column :productions, :target_audience_text_en, :string
  end

  def self.down
    rename_column :productions, :target_audience_text_nl, :target_audience_text
    remove_column :productions, :target_audience_text_fr
    remove_column :productions, :target_audience_text_en
  end
end
