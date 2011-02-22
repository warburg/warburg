module VtiMainController

  def index
    if (controller_name == 'users') && !admin?
      redirect_to root_path
      return
    end
    if params[:q]
      paginate_params = {:similar => { :field => model_class.similar_field, :value => params[:q] }, :page => params[:page], :per_page => 300}
      paginate_params[:conditions] = ["lower(#{model_class.similar_field}) like ?", "%#{params[:q].try(:downcase)}%"]
      @objects = admin? ? model_class.paginate(paginate_params) : model_class.visible.paginate(paginate_params)
      if @objects.empty?
        flash[:error] = t('message.no_search_results')
      end
      @subtitles = {nil => @objects}
      @subtitles_sorted = @subtitles.keys.sort
      @total_lines = @objects.size
    elsif params[:letters]
      if model_class.order_field.match(/.*_id$/) || model_class.order_field.match(/^id$/)
        query_params = {:conditions => ["to_char(#{model_class.order_field}, '999999999') ~* ? ", '^' + params[:letters].downcase.accent_insensitive_regexp + '.*'], :order => model_class.order_field}
      else
        query_params = {:conditions => ["#{model_class.order_field} ~* ? ", '^' + params[:letters].downcase.accent_insensitive_regexp + '.*'], :order => model_class.order_field}
      end
      @objects = admin? ? model_class.all(query_params) : model_class.visible.all(query_params)
      @subtitles = {}
      @objects.each do |object|
        # Notice the weird regexp here. This is to circumvent unicode issues:
        # this regexp gets the 3 first *full characters* (where str[0..2] get the 3 first *bytes*)
        subtitle = object.send(model_class.order_field).unaccent[/..?.?/].strip.capitalize
        @subtitles[subtitle] ||= []
        @subtitles[subtitle] << object
      end
      @subtitles.each do |key, arr|
        @subtitles[key] = arr.sort{|v, w| v.send(model_class.order_field).unaccent.downcase <=> w.send(model_class.order_field).unaccent.downcase}
      end
      @total_lines = @subtitles.size * 2 + @objects.size
      @subtitles_sorted = @subtitles.keys.sort
    else
      @fixed_columns = true
      @subtitles = {}
      @subtitles_sorted = []
      title = t('title.recently_added')
      query_params = {:order => 'created_at desc', :limit => 10}
      @subtitles[title] = admin? ? model_class.all(query_params) : model_class.visible.all(query_params)
      @subtitles_sorted << title
      if model_class.column_names.include?('views')
        title = t('title.most_popular')
        query_params = {:limit => 10, :conditions => ["views is not null"], :order => "views DESC"}
        @subtitles[title] = admin? ? model_class.all(query_params) : model_class.visible.all(query_params)
        @subtitles_sorted << title
      end
      title = t('title.recently_updated')
      query_params = {:order => 'updated_at desc', :limit => 10}
      @subtitles[title] = admin? ? model_class.all(query_params) : model_class.visible.all(query_params)
      @subtitles_sorted << title
      if model_class.column_names.include?('viewed_at')
        title = t('title.recently_viewed')
        query_params = {:limit => 10, :conditions => ["viewed_at is not null"], :order => "viewed_at DESC"}
        @subtitles[title] = admin? ? model_class.all(query_params) : model_class.visible.all(query_params)
        @subtitles_sorted << title
      end
      @total_lines = @subtitles.size * (2 + 10)

    end
    render :template => 'main_klass/index'
  end


  def new
    as_admin do
      @object = model_class.new
      if @object.respond_to?('available')
        if @object.class == PressCutting
          @object.available = false
        else
          @object.available = true
        end
      end
      @object.borrowable = true if @object.respond_to?('borrowable')
      @object.print_barcode = true if @object.respond_to?('print_barcode')
      @relations = model_class.relations
      @relation = @relations[0]
      respond_to do |format|
        format.html { render :template => 'main_klass/edit'}
      end
    end
  end

  def create
    as_admin do
      convertible_attributes = filter_convertible_attributes(params[model_class.name.underscore])
      attributes = params[model_class.name.underscore].merge(convertible_attributes)
      @object = model_class.new(attributes)
      respond_to do |format|
        if @object.save
          flash[:info] = t("message.object_saved")
          format.html { redirect_to(eval("edit_#{controller_name.singularize}_path(@object)")) }
        else
          flash[:error] = t("message.errors_occurred")
          format.html { render :template => 'main_klass/edit' }
        end
      end
    end
  end

  def cloneable
    as_admin do
      old_object = model_class.find(params[:id])

      @object = old_object.clone
      model_class.ignored_columns_when_cloning.each do |column|
        @object.send("#{column}=", nil)
      end
      @object.save

      model_class.cloneable_relations.each do |relation|
        old_object.send(relation).each do |single_association|
          new_association = single_association.clone
          new_association.send("#{model_class.to_s.underscore}_id=", @object.id)
          new_association.save
        end
      end

      redirect_to send("edit_#{model_class.to_s.underscore}_url", @object)
    end
  end

  def edit
    as_admin do
      @object = model_class.find(params[:id])
      @relations = model_class.relations
      @relation = @relations[0]
      respond_to do |format|
        format.html { render :template => 'main_klass/edit'}
      end
    end
  end

  def update
    as_admin do
      @object = model_class.find(params[:id])

      respond_to do |format|
        convertible_attributes = filter_convertible_attributes(params[model_class.name.underscore])
        if @object.update_attributes(params[model_class.name.underscore]) && @object.update_attributes(convertible_attributes)
          flash[:info] = t("message.object_saved")
          format.html { redirect_to(eval("edit_#{controller_name.singularize}_path(@object)")) }
        else
          flash[:error] = t("message.errors_occurred")
          format.html { render :template => "main_klass/edit" }
        end
      end
    end
  end

  def destroy
    as_admin do
      @object = model_class.find(params[:id])
      @object.destroy if @object.present?

      respond_to do |format|
        format.html { redirect_to(eval("#{controller_name}_path")) }
        format.xml  { head :ok }
      end
    end
  end


  def lookup
    paginate_params = {:similar => { :field => model_class.similar_field, :value => params[:q] }, :page => params[:page], :per_page => 10}
    result = admin? ? model_class.paginate(paginate_params) : model_class.visible.paginate(paginate_params)
    respond_to do |format|
      format.html { render(:text => result.to_json) }
      format.js { render :json => result.collect{|r| [r.title, r.id.to_s].join('|')}.join("\n") }
    end
  end

  def search
    as_admin do
      @model_class = model_class
      @query_fields = model_class.search_fields.reject{|field| params[field].blank?}
      conditions = @query_fields.collect { |field|
        if model_class == PeriodicalIssue && field == "title"
          "periodicals.title ilike '%#{model_class.connection.quote_string(params[field]).to_s.strip}%'"
        elsif model_class.new.column_for_attribute(field).type.to_s == "date"
          begin
          "#{field} = '#{Date.parse(model_class.connection.quote_string(params[field]), false, Date::GREGORIAN)}'"
          rescue
            nil
          end
        elsif model_class.new.column_for_attribute(field).type.to_s == "integer"
          "#{field} = #{params[field]}"
        else
          "#{field} ilike '%#{model_class.connection.quote_string(params[field]).to_s.strip}%'"
        end
      }.compact.join(' and ')
      @query_params = @query_fields.collect{|field| params[field]}
      if model_class == PeriodicalIssue
        @objects = conditions.blank? ? [] : model_class.all(:conditions => conditions, :include => :periodical, :limit => 20)
      else
        @objects = conditions.blank? ? [] : model_class.all(:conditions => conditions, :limit => 20)
      end
      @relationship_type = params[:relationship_type]
      @parent = params[:parent_class].constantize.find(params[:parent_id])
      respond_to do |format|
        format.html { render(:nothing => true) }
        format.js { render :layout => false, :template => "main_klass/search" }
      end
    end
  end

  def stickers
    as_admin do
      unless model_class.column_names.include?('barcode')
        render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
        return
      end
      conditions = {'print_barcode' => true}
      if model_class == AudioVideoMedium
        @type = params[:type]
        if @type == 'vhs'
          type = AudioVideoMediumType.find_by_description_nl("VHS")
          conditions.merge!({:audio_video_medium_type_id => type.id})
        end
      end

      @objects = model_class.all(:conditions => conditions)
      @font = 'Helvetica'
      @title_font_size = 8
      @barcode_font_size = 8
      @xdim = 0.75
      # @objects.each{|object| object.update_attributes(:print_barcode => false)} unless (RAILS_ENV == 'development')
      prawnto :prawn => { :page_size => 'A4' }.merge(model_class.sticker_options)
    end
  end

  def reset_stickers
    as_admin do
      unless model_class.column_names.include?('barcode')
        render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
        return
      end
      conditions = {'print_barcode' => true}
      if model_class == AudioVideoMediumType
        @type = params[:type]
        if @type == 'vhs'
          type = AudioVideoMediumType.find_by_description_nl("VHS")
        end
        if @type == 'dvd'
          type = AudioVideoMediumType.find_by_description_nl("DVD")
        end
        conditions.merge!({:audio_video_medium_type_id => type.id})
      end
      @objects = model_class.all(:conditions => conditions)
      @objects.each{|object| object.update_attributes(:print_barcode => false)}
    end
    redirect_to pdf_index_path
  end

  # Get the class from the other side of the relation as viewed from the parent
  # eg. other_side_class(a_person, :production_by_people) will return Production
  def other_side_class(parent, relation_name)
    return Organisation if relation_name == :organisation_relations
    parent_class = (parent.class == Class) ? parent : parent.class
    result = parent_class.reflect_on_association(relation_name.to_sym).class_name.constantize
    if result.respond_to?('other_side_class')
      result = result.other_side_class(parent_class)
    end
    result
  end

  protected

  def as_admin
    if admin?
      yield
    else
      redirect_to :action => :index
    end
  end

  private


  def filter_convertible_attributes(attributes)
    result = {}
    model_class.convertible_attributes_fields.each do |field|
      if attributes[field]
        result[field] = DateIsaar.from_s(attributes[field])
        attributes.delete(field)
      end
    end
    result
  end

end
