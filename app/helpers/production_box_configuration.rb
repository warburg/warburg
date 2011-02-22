module ProductionBoxConfiguration
  include BoxConfiguration

  def columns_for_production_by_people
    cols = []
    cols << { :title => 'name',
              :field => lambda {|obj| link_to(obj.person.title, obj.person) if obj.person} }
    cols << { :title => 'function',
              :field => lambda {|obj| obj.function if obj.function} }
    cols << { :title => 'season_name',
              :field => lambda {|obj| obj.production.season} }
    cols
  end

  def columns_for_production_by_organisations
    cols = []
    cols << { :title => 'name',
              :field => lambda {|obj| link_to(obj.organisation.title, obj.organisation) if obj.organisation} }
    cols << { :title => 'function',
              :field => lambda {|obj| obj.function if obj.function} }
    cols << { :title => 'season_name',
              :field => lambda {|obj| obj.production.season} }
    cols
  end


  def details_for_production_by_people
    dls = []
    dls << {:title => 'role',
            :field => lambda {|obj| obj.role_info if obj.role_info }}
    dls
  end

  def columns_for_shows
    cols = []
    cols << {:title => 'date', :field => lambda{|obj| link_to(obj.date, obj) if obj}}
    cols << {:title => 'venue.venue', :field => lambda{|obj| link_to(obj.venue, obj.venue) if obj and obj.venue}}
    cols
  end

  def any_relations_for_production_by_people?
    lambda do |obj|
      any_relations?(obj, details_for_production_by_people)
    end
  end

end
