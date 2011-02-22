class IdMapper
  def self.execute
    timestamp = Time.now.utc.iso8601.gsub('-', '').gsub(':', '')
    out_name = "#{RAILS_ROOT}/ftpexchange/id_mapping.csv"
    
    File.open(out_name, 'w') do |out|
      out << "Class,PubliekId,permalink\n"
      [Person, Organisation].each do |clazz|
        clazz.find_each do |obj|
          if obj.publicid.present?
            out << "#{clazz.name},#{obj.publicid},http://data.vti.be/#{clazz.table_name}/#{obj.cached_slug}\n"
          end
        end
      end
    end
  end

end