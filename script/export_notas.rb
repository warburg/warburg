d=Dir.new("#{RAILS_ROOT}/app/models/old")
with_nota = []
d.each  do |x| 
    ends_with_s = (x[-4..-4] == 's')
    has_ie = (x[-6..-5] == 'ie')
    classname = x[0..-4].classify
    classname = "#{classname[0..-2]}ie" if has_ie
    classname += 's' if ends_with_s
    if x[0..-4].present?
        clazz = eval("Old::#{classname}") 
        # puts clazz
        if clazz.column_names.include? "Nota"
            with_nota << clazz
        end
    end
end
# puts with_nota.collect{|c|c.name}.inspect

with_nota.reject!{|cl| cl.name == "Old::Ruimte" || cl.name == "Old::OrganisatieFestival"}

with_nota.each{|c|puts c.name}
with_nota.each{|c|puts c.name; puts c.new_class.name}.collect{}

# # puts with_nota.collect{|cl|cl.name}.inspect

def treat_obj(obj, counters, clazz, file)
  if obj.Nota.present?
    counters[clazz] += 1
    file <<  "#{clazz.new_class.name}|#{obj.id}|#{obj.Nota.gsub("\n", " ")}|#{obj.WijzigUser}\n"
    print '.'
  end
end

counters = {}
File.open("#{RAILS_ROOT}/data/notes_migration.csv", 'w') do |file|
  with_nota.each do |clazz|
    counters[clazz] ||= 0
    if clazz.name == "Old::Productie"
      clazz.all(:conditions => "Nota is not null").each do |obj|
        treat_obj(obj, counters, clazz, file)
      end
    else
      clazz.find_each(:conditions => "Nota is not null") do |obj|
        treat_obj(obj, counters, clazz, file)
      end
    end
  end
end
counters.each do |key, value|
  puts "#{key}: #{value}"
end
