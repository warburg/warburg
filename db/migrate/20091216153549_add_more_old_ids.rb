class AddMoreOldIds < ActiveRecord::Migration
  def self.classes
    # [Alumnus, Organisation, AudioVideoMedium, Production, AudioVideoTitle, Article, PressCutting, ArchivePart, 
    #   BookCopy, BookTitle, BoxType, Country, DateIsaar, Donation, Ephemerum, Festival, Function, Gender, Grant,
    #   GrantGenre, GrantState, GrantSystem, IcoTitle, IcoType, Impressum, Language, LanguageRole, LegalForm, Order,
    #   Periodical, PeriodicalIssue, Show, ShowType, User, Warehouse, ArticleLanguage, AudioVideoLanguage, AudioVideoMediumType,
    #   BookTitleLanguage, AudioVideoTitleOnMedium, BookTitleImpressum, EphemerumLanguage, OrganisationRelationType, EphemerumType, 
    #   OrganisationRelation, PeriodicalImpressum, Postit, ProductionGenre, ProductionLanguage, Venue, Relationship, Season, Tagging,
    #   NavigationLetter, Tag]

    [
              User,
              Language,
              LanguageRole,
              Gender,
              Country,
              # Person,
              LegalForm,
              Organisation,
              Donation,
              Periodical,
              Impressum,
              PeriodicalImpressum,
              BoxType,
              Warehouse,
              PeriodicalIssue,
              PeriodicalLanguage,
              Article,
              PressCutting,
              AudioVideoMediumType,
              ArticleLanguage,
              PressCuttingLanguage,
              AudioVideoMedium,
              AudioVideoTitle,
              AudioVideoLanguage,
              ArchivePart,
              BookTitle,
              BookCopy,
              BookTitleImpressum,
              BookTitleLanguage,
              EphemerumType,
              Ephemerum,
              EphemerumLanguage,
              Production,
              ProductionLanguage,
              GrantGenre,
              GrantSystem,
              GrantState,
              Grant,
              Festival,
              AudioVideoTitleOnMedium,
              Alumnus,
              Function,
              IcoType,
              IcoTitle,
              Venue,
              ShowType,
              Show,
              # ProductionGenre,
              OrganisationRelationType,
              OrganisationRelation,
              DateIsaar,      # don't delete!
              Order,
              Relationship,
              Postit,         # don't delete!
              Season,         # don't delete!
              Tagging,
              NavigationLetters, # don't delete!
              Tag
              ]
  end

  def self.up
    classes.each do |clazz|
      add_to_clazz(clazz)
      if clazz.respond_to? 'versioned_class'
        add_to_clazz(clazz.versioned_class)
      end
    end
  end
  
  def self.add_to_clazz(clazz)
    unless clazz.column_names.include?('old_id')
      add_column clazz.table_name, :old_id, :integer
    end
  end
  
  def self.remove_from_clazz(clazz)
    if clazz.column_names.include?('old_id')
      remove_column clazz.table_name, :old_id
    end
  end

  def self.down
    classes.each do |clazz|
      remove_from_clazz(clazz)
      if clazz.respond_to? 'versioned_class'
        remove_from_clazz(clazz.versioned_class)
      end
    end
  end
  
end
