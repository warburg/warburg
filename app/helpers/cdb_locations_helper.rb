module CdbLocationsHelper
  include CdbLocationBoxConfiguration
  def render_field(object, key, value, mode)
    case key
    when "cdb_address"
      field('address', link_to(value.to_s, value))      
    end
  end
  
end