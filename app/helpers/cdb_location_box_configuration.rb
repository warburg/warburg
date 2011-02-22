module CdbLocationBoxConfiguration
  include BoxConfiguration

  def columns_for_cdb_events
    cols = []
    cols << { :title => 'name',
              :field => lambda {|obj| link_to(obj.title, obj)} }
    cols
  end
end