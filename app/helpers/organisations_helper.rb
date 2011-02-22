module OrganisationsHelper
  include OrganisationBoxConfiguration

  def render_field(object, key, value, mode)
    if mode == :show
      case key
      when 'url'
        field(t("label.#{key}"), link_to(value, value))
      when 'genres'
        field(t("label.#{key}"), value.collect{|g|g.title}.join(', ')) unless value.nil?
      when 'festivals'
        field(t("label.#{key}"), value.collect{|f| link_to('Details', f)}.join(', ')) unless value.nil?
      end
    end
  end

end
