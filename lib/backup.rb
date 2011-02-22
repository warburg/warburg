class Backup
  def self.backup_production
    timestamp = Time.now.utc.iso8601.gsub('-', '').gsub(':', '')
    out_name = "#{RAILS_ROOT}/data/vti_production_#{timestamp}.dmp"

    db_config = Rails.configuration.database_configuration['production']

    schema = db_config['schema_search_path']
    schema = schema.split(',').reject {|schema| schema == 'public'}.join(',')
    password = db_config['password']

    command = "export PGPASSWORD=#{password};pg_dump -f #{out_name} -F p -b --username #{db_config['username']} --host #{db_config['host']} --schema #{schema} #{db_config['database']}"

    puts "Going to execute  #{command.gsub(password, '*********')}"

    `#{command}`

    `gzip #{out_name}`

    puts "Written the output to #{out_name}.gz"
  end

end