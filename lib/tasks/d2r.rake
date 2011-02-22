require "friendly_id"
namespace :d2r do
  desc 'Generate the d2r mapping file.'
  task :mapping => :environment do
    ActiveRecord::Base.establish_connection(RAILS_ENV.to_sym)
    out = File.new("#{RAILS_ROOT}/doc/vti-mapping.n3", 'w')
    out << <<HEADER
@prefix map: <file:/home/vti/apps/vti/current/doc/vti-mapping.n3#> .
@prefix db: <> .
@prefix vocab: <http://rdf.vti.be/vocab/resource/> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix d2rq: <http://www.wiwiss.fu-berlin.de/suhl/bizer/D2RQ/0.1#> .
@prefix d2r: <http://sites.wiwiss.fu-berlin.de/suhl/bizer/d2r-server/config.rdf#> .
@prefix jdbc: <http://d2rq.org/terms/jdbc/> .

map:database a d2rq:Database;
	d2rq:jdbcDriver "org.postgresql.Driver";
	d2rq:jdbcDSN "jdbc:postgresql:vti";
  d2rq:username "vtidata";
  d2rq:password "poobae5s";
	.

<> a d2r:Server;
    rdfs:label "D2R Server";
    d2r:baseURI <http://rdf.vti.be/>;
    d2r:port 2020;
	d2r:vocabularyIncludeInstances true;    
    .
HEADER

    classes = [Alumnus]
    handled_classes = []
    
    while cl = classes.pop do
      out << <<GENERAL
# Table production.#{cl.table_name}
<file:/home/vti/apps/vti/current/doc/vti-mapping.n3##{cl.table_name}> a d2rq:ClassMap;
	d2rq:dataStorage map:database;
	d2rq:uriPattern "#{cl.table_name}/\@\@production.#{cl.table_name}.#{cl.param_field}\@\@";
	d2rq:class <http://rdf.vti.be/vocab/resource/#{cl.table_name}>;
	d2rq:classDefinitionLabel "#{cl.table_name}";
	.
<file:/home/vti/apps/vti/current/doc/vti-mapping.n3##{cl.table_name}__label> a d2rq:PropertyBridge;
	d2rq:belongsToClassMap <file:/home/vti/apps/vti/current/doc/vti-mapping.n3##{cl.table_name}>;
	d2rq:property rdfs:label;
	d2rq:pattern "#{cl.table_name} #\@\@production.#{cl.table_name}.#{cl.param_field}\@\@";
	.
GENERAL

      cl.columns.each do |col|
        if !cl.admin_field?(col.name)
          out << <<EOCOL
map:#{cl.table_name}_#{col.name} a d2rq:PropertyBridge;
	d2rq:belongsToClassMap <file:/home/vti/apps/vti/current/doc/vti-mapping.n3##{cl.table_name}>;
	d2rq:property vocab:#{cl.table_name}_#{col.name};
	d2rq:propertyDefinitionLabel "#{cl.table_name} #{col.name}";
	d2rq:column "production.#{cl.table_name}.#{col.name}";
EOCOL
                  xsd_type = case col.sql_type
                              when 'integer': 'int'
                              when /^character.*/: nil
                              when /^timestamp.*/: 'dateTime'
                              when 'boolean': 'boolean'
                              when 'date': 'date'
                              when 'text': nil
                              else "SQL TYPE : #{col.sql_type}"
                             end
                  if xsd_type
                    out << "\td2rq:datatype xsd:#{xsd_type};\n"
                  end
          out << "\t.\n"
    	  end
      end
      
      associations = cl.reflect_on_all_associations(:belongs_to)
      associations = associations.select{|assoc| ![:creator, :updater, :function].include?(assoc.name)}
      associations.each do |assoc|
        # raise assoc.class_name.constantize if assoc.class_name.constantize == "slugs"
        unless %w(Taggable).include?(assoc.class_name)
          assoc_class = assoc.class_name.constantize
          out << <<EOASSOC
map:#{cl.table_name}_#{assoc.name} a d2rq:PropertyBridge;
	d2rq:belongsToClassMap <file:/home/vti/apps/vti/current/doc/vti-mapping.n3##{cl.table_name}>;
	d2rq:property vocab:#{cl.table_name}_#{assoc.name};
	d2rq:refersToClassMap <file:/home/vti/apps/vti/current/doc/vti-mapping.n3##{assoc_class.table_name}>;
	d2rq:join "production.#{cl.table_name}.#{assoc.name}_id = production.#{assoc_class.table_name}.id";
	.
EOASSOC
          unless handled_classes.include?(assoc_class) || classes.include?(assoc_class)
            classes.push assoc_class
          end
        end
      end
      
      has_many_relations = cl.reflect_on_all_associations(:has_many).select{|obj| !obj.options.keys.include?(:through)}
      has_many_relations.each do |relation|
        unless %w(Tagging DocumentIndex OrganisationRelation).include?(relation.class_name)
          relation_class = relation.class_name.constantize
          relation_table_name = if relation_class.ancestors.include?(Relationship)
                            'relationships'
                          else
                            relation_class.table_name
                          end
          out << <<EORELATION
map:#{cl.table_name}_#{relation.name} a d2rq:PropertyBridge;
	d2rq:belongsToClassMap <file:/home/vti/apps/vti/current/doc/vti-mapping.n3##{cl.table_name}>;
	d2rq:property vocab:#{cl.table_name}_#{relation.name};
	d2rq:refersToClassMap <file:/home/vti/apps/vti/current/doc/vti-mapping.n3##{relation_table_name}>;
	d2rq:join "production.#{relation_table_name}.#{cl.table_name.singularize}_id = production.#{cl.table_name}.id";
EORELATION
          if relation_table_name == 'relationships'
            out << "\td2rq:condition \"production.relationships.type = '#{relation_class.name}'\";\n"
          end
          out << "\t.\n"
          unless handled_classes.include?(relation_class) || classes.include?(relation_class)
            classes.push relation_class
          end
        end
      end
      
      handled_classes << cl
    end

    out.close
  end

end