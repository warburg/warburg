module CdbEventsHelper
  include BoxConfiguration
  
  def render_field(object, key, value, mode)
    case key
    when 'cdb_contactinfo'
      field('contactinfo', value.cdb_urls.collect{|url| "<a href='#{url.url}'>#{url.url}</a>"}.join(', '))
    when 'cdb_event_details'
      field('more_details', value.collect{|d| link_to(t("values.more_details"), d)}.join(', '))
    end
  end
  
end