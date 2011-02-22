module VtiHelper

  def markdown_without_paragraph(text)
    markdowned = markdown(text)
    if markdowned[0..2] == "<p>" then markdowned = markdowned[3..-1] end
    if markdowned[-4..-1] == "</p>" then markdowned = markdowned[0..-5] end
    return markdowned
  end

  def details
    []
  end

  def publisher_tag
    "<dc:publisher>#{t('custom.name')}</dc:publisher>"
  end

  # Render the correct url to edit the specified object
  def edit_url(object)
    eval("edit_#{object.class.name.underscore}_url")
  end

  def clone_url(object)
    eval("cloneable_#{object.class.name.underscore}_url")
  end

  # Render a nice title for object.
  def title(object)
    if object
      if object.id
        object.to_s || ''
      else
        t("title.#{object.class.name.underscore}.new")
      end
    end
  end

  def delete_url(object)
    eval("#{object.class.name.underscore}_path(object.to_param, :method => :delete, :authenticity_token => form_authenticity_token)")
  end

  # Render the heading (h2) for the object
  def heading
    if controller_name == 'sessions'
      t('title.login')
    elsif controller_name == 'pdf'
      t "title.pdf"
    else
      if @parent
        link_show(@parent)
      else
        link_show(@object)
      end
    end
  rescue
    title(@object)
  end

  def heading_count
    if controller_name == 'sessions'
      t('title.login').length
    else
      if @parent
        show_count(@parent)
      else
        show_count(@object)
      end
    end
  rescue
    title(@object).length
  end

  def page_title(parent, object)
    result = ''
    result << "#{t('custom.name')} "
    unless controller_name == 'statics'
      result << " - "
      if parent
        result << title(parent)
        result << " - "
        key = controller_name
        key = key[7..-1] if key.starts_with?("nested_")
        result << t("title.#{parent.class.name.underscore}.#{key}")
      else
        result << t("title.#{controller_name}")
      end
    end
    if object
      result << " - "
      result << title(object).to_s
    end
    result
  end

  # Render the linktrail for the object (possibly with the specified parent)
  def linktrail(parent, object, nested = false)
    result = ""
    unless nested
      result << '<ul id="linktrail">'
    end
    if parent
      result << linktrail(nil, parent, true)
      result << '<li> '
      key = controller_name
      key = key[7..-1] if key.starts_with?("nested_")
      result << t("title.#{parent.class.name.underscore}.#{key}")
      result << '</li>'
    else
      result << '<li id="lt-home">'
      if controller_name.starts_with?("cdb")
        result << '<a href="http://www.cultuurdatabank.be/">Cultuurdatabank</a>'
      else
        result << link_to(t('custom.name'), root_path)
      end
      result << '</li>'
      result << '<li> '
      if object
        if !%w(statics).include?(controller_name)
          key = object.class.name.tableize
          result << link_to(t("title.#{key}"), eval("#{key}_path"))
        end
      else
        result << t("title.#{controller_name}")
      end
      result << '</li>'
      if object
        result << '<li> '
        if nested
          result << link_to(title(object), object)
        else
          result << title(object)
        end
        result << '</li>'
      end
    end

    unless nested
      result << '</ul><!-- linktrail -->'
    end
    result
  end

  # Render a link for the show of object, if it is available. Else just show the object title.
  def link_show(object)
    if object
      object.id ? link_to(object, object) : title(object)
    else
      if controller_name == 'static'
      else
        link_to t("title.#{controller.controller_name}"), eval("#{controller.controller_name}_path")
      end
    end
  end

  def show_count(object)
    if object
      object.id ? object.to_param.length : title(object).length
    else
      if controller_name == 'static'
        0
      else
        t("title.#{controller.controller_name}").length
      end
    end
  end

  # Render a link for the edit of object, if it is available. Else show nothing.
  def link_edit(object)
    if admin? && object && object.id
      link_to content_tag(:span, "Edit"), edit_url(object), :style => "float: left; margin-top: 20px; width: 100px;", :class => "button"
    end
  end

  def link_clone(object)
    if admin? && object && object.id && object.class.cloneable?
      link_to content_tag(:span, "Clone"), clone_url(object), :method => :post, :style => "float: left; margin-left: 30px; margin-top: 20px; width: 100px;", :class => "button"
    end
  end

  # Render a link for the delete of object, if it is available. Else show nothing.
  def link_delete(object)
    if admin? && object && object.id
      link_to content_tag(:span, "Delete"), object, :confirm => t('label.are_you_sure'), :method => :delete, :style => "float: right; margin-top: 20px; width: 100px;", :class => "button"
    end
  end

  def search_form_action
    if searchable_classes.include?(controller.controller_name)
      eval("#{controller.controller_name}_path")
    else
      eval("people_path")
    end
  end

  def full_url_for(target)
    "http://#{request.host_with_port}/#{target.class.name.tableize}/#{target.to_param}"
  end

  def rdf_xmlns_declarations
    result = []
    model_classnames.each do |name|
      result << "xmlns:#{name}='#{rdfschemas_url(:classname => name)}'"
    end
    result.join("\n                  ")
  end

  def model_classnames
    unless @model_classnames
      @model_classnames = []
      Dir.new("#{RAILS_ROOT}/app/models").each do |filename|
        unless %w(. ..).include?(filename)
          if (filename =~ /.+\.rb/)
            @model_classnames << filename[0..-4]
          end
        end
      end
    end
    @model_classnames
  end

  def field(label, value, mode = :show)
    if mode == :show
      if value.blank? && (value != false)
        ""
      else
        "<dl><dt>#{label}</dt><dd>#{value}</dd></dl>"
      end
    else
      if value == :in_selector
        ''
      else
        "#{label} #{value}"
      end
    end
  end

  def postits(object)
    Postit.for(object, current_user)
  end


  def error_reports(object)
    ErrorReport.for(object, current_user)
  end

  # Return the current path, but replace (or add) the params hash with the provided options.
  def current_path(options = {})
    url_for(:overwrite_params => options)
  end

  def box(type, object, no_li = false)
      items = admin? ? object.send(type) : object.send(type).select{|r| r.respond_to?('visible') ? (r.visible.nil? ? true : r.visible) : true }
      unless items.empty?
        type_title = base_relation(type)
        render :partial => 'shared/box',
               :locals => {:object => object,
                           :title => t("title.#{object.class.name.underscore}.#{type_title}"),
                           :items => items,
                           :columns => self.send("columns_for_#{type}"),
                           # :details => self.send("details_for_#{type}").any?,        # Do we need an extra column to put the triangle in?
                           # :has_details => self.send("any_relations_for_#{type}?"),  # This method decides if we put a triangle on the current line
                           # :details_link => fetch_details_link(type),                # This method gives the link to the current object
                           :type => type_title,
                           :no_li => no_li
                          }
      end
    rescue StandardError => bang
      logger.error "error while creating box for #{type}"
      logger.error bang
      raise bang
    end

  def tag_box(object, no_li = false)
    items = object.send("taggings")
    unless items.empty?
      type_title = base_relation("taggings")
      render :partial => 'shared/box',
             :locals => {:object => object,
                         :title => t("title.#{object.class.name.underscore}.tags"),
                         :items => items,
                         :columns => self.send("columns_for_taggings"),
                         # :details => self.send("details_for_#{type}").any?,        # Do we need an extra column to put the triangle in?
                         # :has_details => self.send("any_relations_for_#{type}?"),  # This method decides if we put a triangle on the current line
                         # :details_link => fetch_details_link(type),                # This method gives the link to the current object
                         :type => "tags",
                         :no_li => no_li
                        }
    end
  rescue StandardError => bang
    logger.error "error while creating box for tags"
    raise bang
  end

  # Finds the base of the specified relation (e.g. production_by_people_ordered becomes production_by_people)
  def base_relation(relation_name)
    relation_name.to_s.ends_with?('_ordered') ? relation_name.to_s[0..-9] : relation_name.to_s
  end

  def render_field(object, key, value, mode)
  end

  private

  def details_rows(object, form = nil, mode = :show)
    result = ''
    object.each_field(mode, roles) do |key, value|
      result << details_row(object, form, mode, key,value)
    end
    result
  end

  def has_one_relations_in_selector(object)
    result = []
    object.each_field(:edit, roles) do |key, value|
      if key.ends_with?('_id') && object.class.reflect_on_association(key[0..-4].to_sym)
        key = key[0..-4]
      end
      begin
        if render_value_for_edit(object.class, key, nil) == :in_selector
          result << key
        end
      rescue NoMethodError
        # Ignore: this means that form.xxx was called, and thus the result of the above call is not :in_selector
      end
    end
    result
  end

  def relations_in_sequence(object)
    if object.class.respond_to?(:relations_in_sequence)
      relations = object.class.relations_in_sequence
    else
      relations = object.class.shown_relations + has_one_relations_in_selector(object)
    end

    #get organisation_from and to out. And put org_rel in
    if relations.include?(:organisation_from_organisations) && relations.include?(:organisation_to_organisations)
      relations.delete(:organisation_from_organisations)
      relations.delete(:organisation_to_organisations)
      relations << :organisation_relations
    end

    relations.delete(:slugs)
    relations
  end

  def incomplete?
    @object.try(:has_active_error_reports?)
  end

  def details_row(object, form, mode, key, value)
    result = ''
    if (specialized_result = self.render_field(object, key, value, mode))
      result << specialized_result
    else
      if key.ends_with?('_id')
        if refl = object.class.reflect_on_association(key[0..-4].to_sym)
          value = refl.klass.find(value) if value.present?
          key = key[0..-4]
        end
      elsif is_localized_attribute?(key)
        if !roles.include?(:admin) && !key.ends_with?(I18n.locale)
          value = nil
        end
      end
      result << field(render_key(key, roles, mode, form), render_value(object, key, value, form, mode), mode)
    end
    result = "<li>" + result + '</li>' unless result.blank?
    result
  end

  def is_localized_attribute?(key)
    key.ends_with_any?(available_locales)
  end

  def render_key(key, roles, mode = :show, form = nil)
    result = ''
    key = key.to_s
    if is_localized_attribute?(key)
      if roles.include?(:admin)
        result = t("label.#{key[0..-4]}") + " (#{key[-2..-1]})"
      else
        result = t("label.#{key[0..-4]}")
      end
    else
      result = t("label.#{key}")
    end

    if mode == :edit
      result = form.label(key, result)
    end

    result
  end


  def render_value(object, key, value, form, mode)
    if mode == :show
      if key.ends_with?("_file_name") && object.send("picture?")
        image_tag(object.send("picture").url(:small))
      else
        render_value_for_show(value)
      end
    elsif mode == :edit
      render_value_for_edit(object.class, key, form)
    end
  end

  def render_value_for_edit(clazz, key, form)
    key = key.to_s
    type, refl =
      if column = clazz.columns_hash[key]
        [column.klass, nil]
      else
        r = clazz.reflect_on_association(key.to_sym)
        r ? [r.klass, r] : [nil, nil]
      end

    if key.ends_with?("_file_name")
      file_upload_string =  form.file_field(key.gsub("_file_name", ""))
      file_upload_string += "<br /><br />#{image_tag(form.object.send("picture").url(:medium))}" if form.object.send("picture?")
      file_upload_string
    else
      if type
        case type.name
          when 'String', 'Fixnum', 'Date', 'Time'
            form.text_field(key)
          when 'DateIsaar'
            "<input type='text' id='#{clazz.name.underscore}-#{key.underscore}' name='#{clazz.name.underscore}[#{key.underscore}]' value='#{form.object.send(key).for_form if form.object.send(key)}' "
          when 'Object'
            if clazz.columns_hash[key].type == :boolean
              render_dropdown_box(form, key, :boolean)
            else
              "***#{type}***"
            end
          else
            if type.fits_in_dropdown_box?
              render_dropdown_box(form, key, type)
            else
              # raise type.inspect
              :in_selector
            end
        end
      else
        "*** Couldn't handle #{key} ***"
      end
    end
  end

  def render_dropdown_box(form, key, type)
    if type == :boolean
      value = form.object.send(key)
      selected =
        if value.nil?
          nil
        elsif value
          '1'
        else
          '0'
        end
      form.select(key, {'' => nil, 'True' => '1', 'False' => '0'}, {:selected => selected})
    elsif type.name == 'PeriodicalIssue'
      periodical_issue = form.object.send(key)
      periodical = periodical_issue.nil? ? nil : periodical_issue.periodical
      periodical_collection = Periodical.all(:order => 'title asc')
      result = "<select name='periodicals' id='periodicals' onchange='update_periodical_issues();'>" + periodical_collection.collect{|per| "<option value='#{per.id}' #{'selected=\"selected\"' if per == periodical}>#{per.to_s}</option>"}.join("\n") + "</select>"

      collection = periodical.nil? ? [] : periodical.periodical_issues(:order => 'updated_at desc')
      result += form.collection_select("#{key}_id", collection, :id, :to_s, {:include_blank => true})
      result += "<script>\n"
      result += "function update_periodical_issues() {\n"
      result += "$.post('#{update_periodical_issues_list_path}', {periodical_id: $('#periodicals option:selected').attr('value')}, null, 'script')\n"
      result += "}\n"
      result += "</script>"
      result
    elsif type.name == "OrganisationRelationType"
      # select_type =
      collection = OrganisationRelationType.all.map{|ort| [ort.from_name_nl, "#{ort.id}-from"]}
      collection += OrganisationRelationType.all.map{|ort| [ort.to_name_nl, "#{ort.id}-to"]}
      form.hidden_field("direction") <<
      form.select("#{key}_id", collection, {:selected => organisation_relation_selection(form.object)})
    else
      display_method =
        if type.first.respond_to?("to_s_for_combobox")
          :to_s_for_combobox
        else
          :to_s
        end

      collection = sort_all(type, display_method)
      id_method = :id

      form.collection_select("#{key}_id", collection, id_method, display_method, {:include_blank => true})
    end
  end

  def organisation_relation_selection(organisation)
    "#{organisation.organisation_relation_type_id}-#{organisation.direction}"
  end

  def sort_all(type, display_method)
    if type.column_names.include?(display_method)
      type.all(:order => display_method)
    else
      type.all.sort do |a,b|
        ad = a.send(display_method)
        bd = b.send(display_method)
        if ad.nil?
          if bd.nil?
            0
          else
            1
          end
        elsif bd.nil?
          -1
        else
          ad <=> bd
        end
      end
    end
  end

  def render_value_for_show(value)
    if value.nil?
      nil
    elsif value.is_a?(TrueClass) || value.is_a?(FalseClass)
      t("label.yesno.#{value.to_s}")
    elsif value.is_a?(Date)
      l(value)
    elsif value.respond_to?('title')
      if linkable?(value)
        link_to(value.title, value)
      else
        value.title
      end
    elsif value.respond_to?('description_nl')
      Utils.i18n_db_value(value, :description)
    elsif value.respond_to?('name_nl')
      Utils.i18n_db_value(value, :name)
    elsif value.is_a?(Array)
      value.collect{|v| render_value_for_show(v)}.join(', ')
    else
      value.to_s
    end
  end

  # Is the user authorized to see the object?
  def linkable?(object)
    if object.is_a?(Season)
      admin? || object.visible
    elsif ['EphemerumType', 'IcoType', 'Language'].include?(object.class.name)
      false
    else
      true
    end
  end

  def boxes_for(object)
    result = []
    if object.class == Tag
      result << tag_box(object)
    else
      object.class.relations.each do |relation|
        result << box(relation, object)
      end
    end
    result
  end

  def link_to_rescue(obj, title=:title)
    link_to(obj.send(title), obj)
  rescue
    obj.send(title)
  end

  def user_area(&block)
    yield if authorized?
  end

  def body_class
    if relation_view?
      ''
    elsif controller_name == 'sessions'
      'signin'
    elsif controller.action_name == 'index'
      'list'
    else
      'view'
    end
  end

  def relation_view?
    !!@parent
  end

  # Methods for search form


  def search_default_value(klass)
    "#{t('search.search_for')} #{t('title.'+klass).downcase}&hellip;"
  end

  def onblur_value(klass)
    "if (this.value == '') {this.value = $('#q').attr('default_value');}"
  end

  def onfocus_value(klass)
    "if (this.value == $('#q').attr('default_value')) {this.value = '';}"
  end

  def searchable_classes
    main_classes - ['seasons']
  end

  def search_field_default_class
    klass = controller.controller_name
    unless searchable_classes.include?(klass)
      klass = 'people'
    end
    klass
  end

  def search_field
    # klass = search_field_default_class
    "<input type='text' name='q' id='q' />"
            # value='#{search_default_value(klass)}'
            # onblur=\"#{onblur_value(klass)}\"
            # onfocus=\"#{onfocus_value(klass)}\"
            # default_value='#{search_default_value(klass)}'/>"
  end

  def search_onclick_value(klass)
    result = "$('#search').attr('action', '#{eval("#{klass}_path")}');"
    result << "$('#search ul').toggle();"
    title = t("title.#{klass}")
    result << "$('.more-menu-field p').replaceWith('<p>#{title}</p>');"
#    result << "$('#search').submit();"
    result
  end

  def help_classes_menu_items
    result = ''
    first = true
    first_cdb = true
    help_classes_sorted.each do |cl|
     if cl.starts_with?('cdb') && first_cdb
       result << '<li class="separator">&nbsp;</li>'
       first_cdb = false
     end
      result << "<li"
      if first
        result << " class='first'"
        first = false
      end
      result << ">"
      result << link_to(t("title.#{cl}"), eval("#{cl}_path"))
      result << link_to(t("title.#{cl.singularize}.new"), eval("new_#{cl.singularize}_path"), :class => 'new') unless cl.starts_with?('cdb')
      result << "</li>"
    end
    result
  end

  def barcodes_menu_items
    result = ''
    first = true
    %w(warehouses vhss dvds book_copies periodical_issues).sort.each do |cl|
      options = {:class => 'first'} if first
      first = false
      result << content_tag('li', options) do
        conditions = {'print_barcode' => true}
        path_parameters = {:format => :pdf}
        if cl == 'vhss'
          type = AudioVideoMediumType.find_by_description_nl("VHS")
          conditions.merge!({:audio_video_medium_type_id => type.id})
          path_parameters.merge!({:type => 'vhs'})
          clazz = AudioVideoMedium
        end
        if cl == 'dvds'
          # type = AudioVideoMediumType.find_by_description_nl("DVD")
          # conditions.merge!({:audio_video_medium_type_id => type.id})
          # path_parameters.merge!({:type => 'dvd'})
          clazz = AudioVideoMedium
        end
        clazz ||= cl.classify.constantize
        count = clazz.count(:conditions => conditions)
        pdf_link   = link_to(t("label.pdf.print"), eval("stickers_#{clazz.name.pluralize.underscore}_path(path_parameters)"))
        reset_link = link_to(t("label.pdf.reset"), eval("reset_stickers_#{clazz.name.pluralize.underscore}_path(path_parameters)"), :confirm => t('label.are_you_sure'))

        if count > 0
          "#{t("title.#{cl}")} (#{count}) - #{pdf_link} - #{reset_link}"
        else
          "#{t("title.#{cl}")} (#{count})"
        end
      end
    end
    content_tag(:ul, content_tag(:li, content_tag(:ul, result), { :class => 'column' }), :id => "browser-results")
  end

  def help_classes_sorted
    help_classes.sort do |x,y|
      result = t("title.#{x}") <=> t("title.#{y}")
      if x.starts_with?('cdb') && !y.starts_with?('cdb')
        result = 1
      end
      if y.starts_with?('cdb') && !x.starts_with?('cdb')
        result = -1
      end
      result
    end
  end

  def browser_results
    columns = 4
    result = ''
    result << '<ul id="browser-results">'

    if @fixed_columns
      current_column  = 1

      result << '<li class="column">'
      @subtitles_sorted.each do |title|
        if title
          result << "<h3>#{title}</h3>"
        end
        result << '<ul>'
        @subtitles[title].each do |object|
          result << "<li>#{link_to((object.is_a?(Production) ? object.to_s : object.title), object)}</li>"
        end
        current_column += 1
        result << "</ul></li><li class='column #{'last' if (current_column == columns)}'>"
      end
      result << "</li></ul>"
    else
      rest = @total_lines % columns
      nrincolumns = ((@total_lines - rest) / columns)
      nrincolumns += 1 if rest > 0

      counter = 0
      current_column  = 1

      result << '<li class="column">'
      @subtitles_sorted.each do |title|
        if title
          result << "<h3>#{title}</h3>"
          counter += 2
        end
        result << '<ul>'
        @subtitles[title].each do |object|
          result << "<li>#{link_to((object.is_a?(Production) ? object.to_s : object.title), object)}</li>"
          counter += 1
          if counter >= nrincolumns
            counter = 0
            current_column += 1
            result << "</ul></li><li class='column #{'last' if (current_column == columns)}'><ul>"
          end
        end
        result << "</ul>"
      end
      result << "</li>"
    end

    result << "</ul>"
    result
  end

  def edit_form_id(object)
    if object.id
      "#edit_#{object.class.name.underscore}_#{object.id}"
    else
      "#new_#{object.class.name.underscore}"
    end
  end

  def navigation_letters
    model_class = controller.controller_name.classify
    # logger.debug "model_class #{model_class}, action #{controller.action_name}"
    if (model_class == 'PressCutting') && (controller.action_name.to_s == 'todo')
      nil
    else
      NavigationLetters.find_by_classname(model_class)
    end

  end

end

