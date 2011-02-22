module PersonBoxConfiguration
  include BoxConfiguration

  def columns_for_production_by_people_ordered_at_person
    cols = []
    cols << { :title => 'name',
              :field => lambda {|obj| link_to(obj.production.title, obj.production)} }
    cols << { :title => 'function',
              :field => lambda {|obj| obj.function if obj.function} }
    cols << { :title => 'season_name',
              :field => lambda {|obj| obj.production.season} }
    cols
  end
  alias :columns_for_production_by_people_ordered :columns_for_production_by_people_ordered_at_person

  def details_for_production_by_people_ordered
    dls = []
    dls << {:title => 'role',
            :field => lambda {|obj| obj.role_info if obj.role_info }}
    dls
  end

  def any_relations_for_production_by_people?
    lambda do |obj|
      any_relations?(obj, details_for_production_by_people)
    end
  end

end
