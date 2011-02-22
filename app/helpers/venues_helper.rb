module VenuesHelper
  include BoxConfiguration
  
  def columns_for_organisation_venues
    cols = []
    cols << { :title => 'name',
              :field => lambda {|obj| link_to(obj.organisation.title, obj.organisation) if obj.organisation} }
    cols
  end
  
end