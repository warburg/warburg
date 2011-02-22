require 'libxml'
require 'pp'

class CdbXmlReader
  include LibXML

  CDB_NS = 'http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL'

  NS = {'cdb' => CDB_NS}

  # Find the categories on http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL/categories/1.8/categorisation.xml
  PERFORMING_ARTS_CATEGORIES = %w(1.9.0.0.0 1.9.1.0.0 1.9.2.0.0 1.9.3.0.0 1.9.4.0.0 1.9.5.0.0 1.3.0.0.0 1.3.1.0.0
                                  1.3.2.0.0 1.3.3.0.0 1.3.4.0.0 1.3.5.0.0 1.3.6.0.0 1.3.7.0.0 1.3.8.0.0 1.3.9.0.0
                                  1.4.0.0.0 1.5.0.0.0 1.6.0.0.0)
  
  attr_reader :reader, :debug, :events, :productions, :counters
  
  def initialize(file, debug=false)
    @reader = XML::Reader.file(file)
    @debug = debug
    @productions = []
    @counters = {}
    @event_count = 0
  end
  
  def process
    reader.read
    handle_cdbxml
    reader.close
  end
  
  def handle_cdbxml
    name = "cdbxml"
    ns = reader['xmlns']
    if ns == CDB_NS
      reader.read until (reader.name == 'events')
      handle_events
    else
      raise StandardError.new("Unsupported namespace: #{ns}")
    end
  end

  def handle_event
    @event_count += 1
    puts "Enter event ##{@event_count}"
    if reader.name != 'event'
      raise StandardError.new("Incorrect node: #{reader.name}")
    end
    node = reader.expand

    context = node.context
    context.register_namespace('cdb', CDB_NS)

    category_ids = get_categories(context)
    is_performing_art = (PERFORMING_ARTS_CATEGORIES & category_ids).size > 0

    # Check categories
    if is_performing_art
      cdbid = node['cdbid']
      if cdbid
        event = CdbEvent.find_or_create_by_cdbid(cdbid)
      else
        event = CdbEvent.new
      end
      event_hash = Crack::XML.parse(node.to_s)['event']
      
      parse_calendar(context, event)
      event.cdb_contactinfo = parse_contactinfo(event_hash['contactinfo'])
      parse_eventcategories(context, event)
      parse_eventdetails(context, event)
      event.cdb_location = parse_location(event_hash)
      parse_eventrelations(event_hash, event)
      
      event.save!
      puts "Saved event #{event.to_s} (permalink: #{event.cached_slug} )"
    end
  end
  
  def parse_eventrelations(hash, event)
    event.cdb_related_production = parse_related_production(hash['eventrelations'])
    parse_parent_events(hash['eventrelations']).each do |pe|
      event.cdb_parent_events << pe
      pe.save!
    end
  end
  
  def parse_parent_events(hash)
    return [] unless hash
    result = []
    arrayize(hash['parentevent']).each do |pe_hash|
      pe = CdbParentEvent.new
      %w(cdbid externalid).each do |field|
        pe[field] = pe_hash[field]
      end
      pe = existing(pe) || pe
      result << pe
      pe.save!
    end
    result
  end
  
  def parse_related_production(hash)
    return nil unless hash
    rp_hash = hash['relatedproduction']
    if rp_hash
      rp = CdbRelatedProduction.new
      %w(cdbid externalid).each do |field|
        rp[field] = rp_hash[field]
      end
      rp = existing(rp) || rp
      rp.save!
      rp
    end
  end
  
  def parse_location(event_hash)
    location = CdbLocation.new
    address = parse_address(event_hash['location'])
    if address.cdb_location
      location = address.cdb_location
    else
      location.cdb_address = address
    end
    
    location.cdb_actor = parse_actor_or_label(event_hash['location'])
    location.save!
    location
  end
  
  def parse_address(hash)
    if address_hash = hash['address']
      address = CdbAddress.new
      %w(main reservation).each do |field|
        address[field] = address_hash[field] rescue nil
      end
      
      pa = parse_physical_address(address_hash)
      if pa
        if pa.cdb_address
          address = pa.cdb_address
        else
          pa.cdb_address = address
          pa.save!
        end
      end
      
      va = parse_virtual_address(address_hash)
      if va
        if va.cdb_address
          address = va.cdb_address
        else
          va.cdb_address = address
          va.save!
        end
      end
      address = existing(address) || address
      address.save!
      
      address
    end
  end
  
  def parse_physical_address(hash)
    phys_hash = hash['physical']
    if phys_hash
      pa = CdbPhysicalAddress.new
      %w(housenr zipcode).each do |field|
        pa[field] = phys_hash[field]['text'] rescue nil
      end
      pa.cdb_city = parse_city(phys_hash)
      pa.cdb_gis = parse_gis(phys_hash)
      pa.country = Country.find_by_iso_code(phys_hash['country']['text']) rescue nil
      pa.cdb_street = parse_street(phys_hash)
      
      pa = existing(pa, [:cdb_address_id]) || pa
      
      pa.save!
      return pa
    end
    return nil
  end
  
  def existing(object, ignore = [])
    conditions = object.attributes
    conditions.delete("id")
    conditions.delete('created_at')
    conditions.delete('updated_at')
    ignore.each do |f|
      conditions.delete f.to_s
    end
    object.class.first(:conditions => conditions)
  end
  
  def parse_street(hash)
    sh = hash['street']
    if sh
      # Should be this, but CDBID is not filled out: CdbStreet.find_or_create_by_cdbid(sh['cdbid'])
      CdbStreet.find_or_create_by_street(sh['text'])
    end
  end
  
  def parse_gis(hash)
    gh = hash['gis']
    if gh
      gis = CdbGis.new
      %w(xcoordinate ycoordinate).each do |field|
        gis[field] = gh[field]['text']
      end
      gis = existing(gis) || gis
      gis.save!
      gis
    end
  end
  
  def parse_city(hash)
    ch = hash['city']
    if ch
      city = nil
      if ch['cdbid']
        city = CdbCity.find_or_create_by_cdbid(ch['cdbid'])
      else
        city = CdbCity.find_or_create_by_city(ch['text'])
      end
      city.city = ch['text']
      city.save!
      city
    end
  end
  
  def parse_virtual_address(hash)
    virt_hash = hash['virtual']
    if virt_hash
      va = CdbVirtualAddress.new
      va.title = virt_hash['title']['text'] rescue nil
      va = existing(va, [:cdb_address_id]) || va
      va.save!
      va
    end
  end

  def parse_eventdetails(context, event)
    event.cdb_event_details.destroy_all
    nodes = context.find("cdb:eventdetails/cdb:eventdetail")
    nodes.each do |node|
      hash = Crack::XML.parse(node.to_s)['eventdetail']
      event_detail = CdbEventDetail.new
      event_detail.language = Language.find_by_locale(node['lang'])
      %w(admission calendarsummary estimatedtime shortdescription longdescription title).each do |field|
        event_detail[field] = hash[field]['text'] if hash[field]
      end

      price = CdbPrice.new(:pricevalue => hash['price']['pricevalue']['text'].gsub(',','.').to_f) rescue nil
      if price
        price.pricedescription = hash['price']['pricedescription']['text'] rescue nil
      end

      event_detail.cdb_price = price
      price.save! if price
      
      if hash['performers']
        arr = arrayize(hash['performers']['performer'])
        arr.each do |performer_hash|
          performer = CdbPerformer.new
          performer.role = performer_hash['role']['text'] rescue nil
          performer.cdb_actor = parse_actor_or_label(performer_hash)
          performer = existing(performer) || performer
          event_detail.cdb_performers << performer
          performer.save!
        end
      end
      event.cdb_event_details << event_detail
      event_detail.save!
    end
  end
  
  def parse_actor_or_label(hash)
    label_hash = hash['label']
    if label_hash
      actor = nil
      if label_hash['cdbid']
        actor = CdbActor.find_or_create_by_cdbid(label_hash['cdbid'])
      else 
        actor = CdbActor.new
      end
      actor.externalid = label_hash['externalid']
      actor.label = label_hash['text']
      actor = existing(actor) || actor
      actor.save!
      actor
    else
      parse_actor(hash['actor'])
    end
  end
  
  def parse_contactinfo(contact_hash)
    if contact_hash && contact_hash['url']
      ci = CdbContactinfo.new
      arrayize(contact_hash['url']).each do |url_hash|
        url = CdbUrl.new(:url => url_hash['text'])
        url.main = url_hash['main']
        url.reservation = url_hash['reservation']
        url = existing(url) || url
        ci.cdb_urls << url
        url.save!
      end
      ci.save!
      ci
    end
  end
  
  def parse_actor(actor_hash)
    actor = nil
    if actor_hash['cdbid']
      actor = CdbActor.find_or_create_by_cdbid(actor_hash['cdbid'])
    else
      actor = CdbActor.new
    end
    actor.externalid = actor_hash['externalid']
    actor.private = actor_hash['private']
    actor.person = actor_hash['person']
    arrayize(actor_hash['actordetails']['actordetail']).each do |ad_hash|
      ad = actor.cdb_actor_details.find_or_create_by_language_id(Language.find_by_locale(ad_hash['lang']).id)
      %w(longdescription shortdescription title).each do |field|
        ad[field] = ad_hash[field]['text'] rescue nil
      end
      ad.save!
    end
    actor.cdb_contactinfo.destroy if actor.cdb_contactinfo
    actor.cdb_contactinfo = parse_contactinfo(actor_hash['contactinfo']) 
    actor.save!
    actor
  end
  
  def arrayize(obj)
    return [] if obj.nil?
    obj.is_a?(Array) ? obj : [obj]
  end

  def parse_eventcategories(context, event)
    event.cdb_category_cdb_events.destroy_all
    parse_category('admittance', context, event)
    parse_nested_categories('facilities', 'facility', context, event)
    parse_category('publicscope', context, event)
    parse_nested_categories('targetaudiences', 'targetaudience', context, event)
    parse_nested_categories('themes', 'theme', context, event)
    parse_nested_categories('types', 'type', context, event)
  end

  def parse_category(node_name, context, event)
    node = context.find("cdb:eventcategories/cdb:#{node_name}")
    unless node.empty?
      add_category(node[0], event)
    end
  end

  def add_category(node, event)
    attribs = {:catid => node['catid'], :description => node['description'], :text => node.content}
    event.cdb_categories << (CdbCategory.first(:conditions => attribs) || CdbCategory.create(attribs))
  end

  def parse_nested_categories(main_node_name, node_name, context, event)
    context.find("cdb:eventcategories/cdb:#{main_node_name}/cdb:#{node_name}").each do |node|
      add_category(node, event)
    end
  end

  def parse_calendar(context, event)
      context.find("cdb:calendar/cdb:timestamps/cdb:timestamp").each do |timestamp_node|
        cancelled = false
        ts = CdbTimestamp.new
        datestr = nil
        timestamp_node.each_element do |dt|
          if dt.name == 'date'
            datestr = dt.content
            ts.date = Date.parse(datestr)
          elsif dt.name == 'timestart'
            begin
              ts.timestart = Time.parse("#{datestr} #{dt.content}")
            rescue StandardError => bang
              puts "Couldn't parse #{datestr} #{dt.content}"
            end
          elsif dt.name == 'timeend'
            begin
              ts.timeend = Time.parse("#{datestr} #{dt.content}")
            rescue StandardError => bang
              puts "Couldn't parse #{datestr} #{dt.content}"
            end
          elsif dt.name == 'availability'
            child = dt.first
            if (child.name == 'cancelled') && child.content == 'true'
              cancelled = true
            end
          else
            raise StandardError.new("Unexpected node in timestamp: #{dt.name}; timestamp: #{timestamp_node.inspect}")
          end
        end

        existing_ts = event.cdb_timestamps.first(
              :conditions => {:date => ts.date,
                              :timestart => ts.timestart,
                              :timeend => ts.timeend})

        if existing_ts && cancelled
          existing_ts.destroy
        elsif !existing_ts
          event.cdb_timestamps << ts
          ts.save!
        end
      end
  end

  def xml_attribute(attribute, xpath, contekst)
    nodes = contekst.find(xpath)
    if nodes.size > 1
      raise StandardError.new("Too many nodes found for #{xpath}")
    elsif !nodes.blank?
      yield(nodes[0][attribute])
    end
  end

  def value(contekst, xpath)
    nodes = contekst.find(xpath)
    if nodes.size < 1
      return nil
    else
      return nodes[0].content
    end
  end

  def values(contekst, xpath)
    nodes = contekst.find(xpath)
    result = []
    nodes.each do |node|
      result << node.content
    end
    result
  end

  def get_categories(contekst)
    themes = contekst.find('cdb:eventcategories/cdb:themes/cdb:theme')
    themes.collect{|theme| theme['catid']}
  end


  def handle_events
    while reader.read #&& @event_count < 85
      if reader.name == 'event'
        handle_event
      end
    end
  end
    
end

