module SeasonsHelper
  include SeasonBoxConfiguration
  
  def render_field(object, key, value, mode)
    if mode == :edit
      case key
      when 'end_year'
        # This is calculated: don't edit.
        ''
      when 'name'
        # This is calculated: don't edit.
        ''
      end
    end
  end
  
  
end
