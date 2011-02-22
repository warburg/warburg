module BookTitlesHelper
  include BookTitleBoxConfiguration

  def render_field(object, key, value, mode)
    if mode == :show
      case key
      when 'issn'
        field(key, link_to(value, object.antilope, :target => 'blank', :title => 'Antilope'))
      when 'antilope'
        ''
        # do nothing: used in 'issn' case
      end
    end
  end

end
