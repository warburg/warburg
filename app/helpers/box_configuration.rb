module BoxConfiguration

  def columns_for_author_of_documents
    cols = []
    cols << { :title => 'name',
             :field => lambda {|rel|
                      obj = rel.other_side(rel.author)
                      link_to obj.title, obj} }

    cols << { :title => 'date',
             :field => lambda {|rel|
                          obj = rel.other_side(rel.author)
                          if obj.respond_to?('appearance_date')
                            date = obj.appearance_date
                            if date.is_a?(Time) || date.is_a?(Date) || date.is_a?(DateTime)
                              l(date)
                            else
                              date
                            end
                          else
                            nil
                          end
                         }
            }
    cols << { :title => 'type',
             :field => lambda {|rel|
                   obj = rel.other_side(rel.author)
                   t "class.#{obj.class}"} }
    cols
  end

  def details_for_author_of_documents
    cols = []
    cols << { :title => 'function',
              :field => lambda {|rel| rel.function if rel.respond_to?("function")} }
    cols << { :title => 'location',
              :field => lambda {|rel|
                            obj = rel.other_side(rel.author)
                            result = obj.library_location if obj.respond_to?('library_location')
                            result ||= obj.warehouse if obj.respond_to?('warehouse')
                            result
                          }
            }
    # cols << { :title => 'warehouse',
    #           :field => lambda {|rel|
    #                         obj = rel.other_side(rel.author)
    #                         obj.warehouse if obj.respond_to?('warehouse')
    #                       }
    #         }
    cols
  end

  def fetch_details_link(relation, obj)
    # Fugly hack to get the source of the relation
    source_class = request.path.split('/')[1].classify

    # lambda do |obj|
      arrow_dom_id = fetch_arrow_dom_id(obj)
      rvalue = link_to("Details", "##{arrow_dom_id}", :class => "closed", :id => "#{arrow_dom_id}")
      rvalue << "<script>$('##{arrow_dom_id}').one('click', function(){
      $.ajax({type:'GET', url:'#{fetch_path(fetch_tr_dom_id(obj), obj.class.to_s, obj.id, relation, source_class)}', dataType:'script'})
      });</script>"
      rvalue
    # end
  end


  def columns_for_subject_of_documents
    cols = []
    cols << { :title => 'name',
              :field => lambda {|rel|
                                  obj = rel.other_side(rel.subject)
                                  link_to obj.title, obj} }
    cols << { :title => 'date',
              :field => lambda { |rel|
                          obj = rel.other_side(rel.subject)
                          if obj.respond_to?('appearance_date')
                            date = obj.appearance_date
                            if date.is_a?(Time) || date.is_a?(Date) || date.is_a?(DateTime)
                              l(date)
                            else
                              date
                            end
                          else
                            nil
                          end
                       }
            }
    cols << { :title => 'type',
              :field => lambda {|rel|
                          obj = rel.other_side(rel.subject)
                          t "class.#{obj.class}"} }
    cols
  end

  def details_for_subject_of_documents
    cols = []
    cols << { :title => 'location',
              :field => lambda {|rel|
                            obj = rel.other_side(rel.subject)
                            result = obj.library_location if obj.respond_to?('library_location')
                            result ||= obj.warehouse if obj.respond_to?('warehouse')
                            result
                          }
            }
    cols
  end


  def columns_for_author_relations
    cols = []
    cols << { :title => 'name',
              :field => lambda {|obj|
                if obj.respond_to?('person')
                  link_to(obj.person.name, obj.person) if obj.person
                elsif obj.respond_to?('organisation')
                  link_to(obj.organisation.name, obj.organisation) if obj.organisation
                end } }
    cols << { :title => 'function',
      :field => lambda {|rel| rel.function if rel.respond_to?("function")} }
    cols << { :title => 'type',
             :field => lambda {|obj|
                if obj.respond_to?('person')
                  t "class.person"
                elsif obj.respond_to?('organisation')
                  t "class.organisation"
                end } }
    cols
  end

  def columns_for_subject_relations
    cols = []
    cols << { :title => 'name',
              :field => lambda {|obj|

                if obj.respond_to?('person')
                  link_to(obj.person.name, obj.person) if obj.person
                elsif obj.respond_to?('organisation')
                  link_to(obj.organisation.name, obj.organisation) if obj.organisation
                elsif obj.respond_to?('production')
                  link_to(obj.production.title, obj.production) if obj.production #&& obj.production.visible == false
                end } }
    cols << { :title => 'type',
             :field => lambda {|obj|
                if obj.respond_to?('person')
                  t "class.person"
                elsif obj.respond_to?('organisation')
                  t "class.organisation"
                elsif obj.respond_to?('production')
                  t "class.production"
                end } }
    cols
  end

  def columns_for_contains_documents
    cols = []
    cols << { :title => 'name',
              :field => lambda {|obj| link_to(obj.title, obj)} }
    cols << { :title => 'date',
              :field => lambda {|obj| l(obj.date) if (obj.respond_to?("date") && obj.date)} }
    cols << { :title => 'type',
              :field => lambda {|obj| t("class.#{obj.class.name}")} }
    cols
  end

  def columns_for_periodical_issues
    cols = []
    cols << { :title => 'name',
              :field => lambda {|obj| link_to(obj.title, obj)} }
    cols
  end
  alias :columns_for_periodical_issues_ordered :columns_for_periodical_issues

  def columns_for_about_genres
    cols = []
    cols << { :title => 'name',
              :field => lambda {|obj| link_to(obj.title, obj)} }
    cols
  end

  def columns_for_production_about_genres
    cols = []
    cols << { :title => 'name',
              :field => lambda {|obj| link_to(obj.genre.title, obj)} }
    cols
  end

  def columns_for_impressums
    cols = []
    cols << { :title => 'publisher',
              :field => lambda {|obj| link_to(obj.publisher, obj)} }
    cols
  end

  def columns_for_book_title_languages
    cols = []
    cols << { :title => 'name',
              :field => lambda {|obj| obj.language.name_nl} }
    cols
  end

  def columns_for_ephemerum_languages
    cols = []
    cols << { :title => 'name',
              :field => lambda { |obj| obj.language.name_nl } }
    cols
  end

  def columns_for_press_cutting_languages
    cols = []
    cols << { :title => 'name',
              :field => lambda {|obj| obj.language.name_nl} }
    cols
  end

  def columns_for_production_languages
    cols = []
    cols << { :title => 'name',
              :field => lambda {|obj| obj.language.name_nl} }
    cols
  end

  def columns_for_book_title_impressums
    cols = []
    cols << { :title => 'name',
              :field => lambda {|obj| obj.impressum.publisher } }
    cols
  end

  def columns_for_book_copies
    cols = []
    cols << { :title => 'library_location',
              :field => lambda {|obj| link_to(obj.library_location, obj)} }
    cols
  end

  def columns_for_articles
    cols = [{  :title => 'title',
              :field => lambda {|obj| link_to(obj.title, obj)} }]
  end


  def any_relations_for_author_of_documents?
    lambda do |obj|
      any_relations?(obj, details_for_author_of_documents)
    end
  end

  def any_relations_for_subject_of_documents?
    lambda do |obj|
      any_relations?(obj, details_for_subject_of_documents)
    end
  end

  def any_relations?(obj, relations)
    for relation in relations
      return true unless relation[:field].call(obj).blank?
    end
    return false
  end

  def method_missing(method, *args)
    if /any_relations/ =~ method.to_s
      lambda { |obj| false } # no relations, return false
    #elsif /fetch_/ =~ method.to_s
    #  lambda { |obj| "" } # no link, return empty string
    elsif /details_for_/ =~ method.to_s
      []
    else
      super(method, args)
    end
  end

  def details_for_seasons
    rows = []
    rows
  end


  def box_relations_for_seasons
    []
  end


  protected

    def fetch_tr_dom_id(obj)
      "#{obj.class.to_s}-#{obj.id}"
    end

    def fetch_arrow_dom_id(obj)
      "l-#{obj.id}"
    end

    def t(str)
      I18n.translate(str)
    end


end
