module CdbPhysicalAddressesHelper
  def render_field(object, key, value, mode)
    case key
    when "cdb_street_id"
      field('cdb_street', CdbStreet.find(value).street)
    end
  end
end