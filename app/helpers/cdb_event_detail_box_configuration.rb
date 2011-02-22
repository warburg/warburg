module CdbEventDetailBoxConfiguration
  include BoxConfiguration
  
  def columns_for_cdb_performers
    cols = []
    cols << { :title => 'actor',
              :field => lambda {|obj| link_to(obj.cdb_actor, obj.cdb_actor) if obj.cdb_actor} }
    cols << { :title => 'role',
              :field => lambda {|obj| obj.role} }
    cols << { :title => 'label',
              :field => lambda {|obj| obj.label} }
    cols
  end
end

