def check(cl, obj)
  org_or_person = [Person, Organisation]
  
  relation_name = "#{cl.name.underscore}_by_#{obj.name.underscore}"
  relation = eval(relation_name.classify)
  function_type = eval("#{obj.name}Function")
  other_function_type = eval "#{org_or_person.reject{|oop| oop == function_type}[0].name}Function"
  

  h = relation.count(:conditions => 'function_id is not null', :group => 'function_id')
  h.each do |key, value|
    f = Function.find key
    if f.is_a? function_type
      # puts "#{key}: ok (#{f.class} for a #{relation_name})"
    else
      other_function_id = other_function_type.find_by_old_id(f.old_id).id
      puts "***#{key}: nok (#{f.class} for a #{relation_name}, f.old_id = #{f.old_id}, other_function_id = #{other_function_id})"
      query = "update relationships set function_id = #{other_function_id} where function_id = #{f.id} and type='#{relation_name.classify}'"
      Person.connection.update_sql(query)
      # puts query
    end
  end
end

classes = [Article, AudioVideoTitle, BookTitle, Ephemerum, IcoTitle, PressCutting, Production]
org_or_person = [Person, Organisation]

classes.each do |cl|
  org_or_person.each do |obj|
    check(cl, obj)
  end
end
