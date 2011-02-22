module CdbActorsHelper
  include BoxConfiguration
  
  def render_field(object, key, value, mode)
    case key
    when 'cdb_contactinfo'
      field('contactinfo', value.cdb_urls.collect{|url| "<a href='#{url.url}'>#{url.url}</a>"}.join(', '))
    end
  end
  
end