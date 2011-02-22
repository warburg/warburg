module PeriodicalsHelper
  include PeriodicalBoxConfiguration

  def render_field(object, key, value, mode)
    case key
    when 'issn'
      if mode == :show
        field(t("label.issn"), link_to(value, object.antilope, :target => 'blank', :title => 'Antilope'))
      end
    when 'antilope'
      ''
      # do nothing: used in 'issn' case
    end
  end

end
