module ArticlesHelper
  include ArticleBoxConfiguration

  def render_field(object, key, value, mode)
    case key
    when 'periodical_issue'
      field('periodical', link_to(value.periodical.title, value.periodical))
    end
  end
end
