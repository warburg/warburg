module OrganisationBoxConfiguration
  include BoxConfiguration

  def columns_for_production_by_organisations_ordered_at_organisation
    cols = []
    cols << { :title => 'name',
              :field => lambda {|obj| link_to(obj.production.title, obj.production)} }
    cols << { :title => 'function',
              :field => lambda {|obj| obj.function if obj.function} }
    cols << { :title => 'season_name',
              :field => lambda {|obj| obj.production.season} }
    cols
  end
  alias :columns_for_production_by_organisations_ordered :columns_for_production_by_organisations_ordered_at_organisation
  
  def columns_for_organisation_relations
    cols = []
    cols << { :title => 'name',
              :field => lambda { |obj| if obj.direction == 'from'
                                        link_to obj.organisation_from, obj.organisation_from 
                                      else
                                        link_to obj.organisation_to, obj.organisation_to
                                      end
                                }
            }
    cols << { :title => 'type',
              :field => lambda { |obj| if obj.direction == 'from'
                                          obj.organisation_relation_type.localized("from_name") if obj.organisation_relation_type 
                                       else
                                         obj.organisation_relation_type.localized("to_name") if obj.organisation_relation_type 
                                       end
                               }
            }
    cols
  end
  
  def columns_for_organisation_from_organisations
    cols = []
    cols << { :title => 'name',
              :field => lambda { |obj| link_to obj.organisation_from, obj.organisation_from } }
    cols << { :title => 'type',
              :field => lambda { |obj| obj.organisation_relation_type if obj.organisation_relation_type } }
    cols
  end
  
  def columns_for_organisation_to_organisations
    cols = []
    cols << { :title => 'name',
              :field => lambda { |obj| link_to obj.organisation_to, obj.organisation_to } }
    cols << { :title => 'type',
              :field => lambda { |obj| obj.organisation_relation_type if obj.organisation_relation_type } }
    cols
  end
  
  def columns_for_grants
    cols = []
    cols << { :title => 'grants',
              :field => lambda {|obj|
                                  link_to(obj.grant_system.description, obj)
                                } 
            }
    cols
  end
  
end
