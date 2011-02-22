@@users = {}

def get_user(old_user_id)
  result = @@users[old_user_id]
  if result.nil?
    result = User.find_by_old_id(old_user_id)
    @@users[old_user_id] = result
  end
  result
end

def attach_postit(n, note, user)
  if note.present?
    @postit_lang_id ||= Language.find_by_iso_code("DUT")
    # log.progress "Creating postit"
    postit = Postit.new(:text => note, :language_id => @postit_lang_id, :user_id => user.id)
    postit.postitable = n
    postit.save(false)
  end
end




current_class_name = nil

loaded = [] # %w(Organisation PeriodicalIssue Donation GrantGenre ArchivePart BookCopy Warehouse IcoTitle Person Alumnus Article BookTitle Show GrantSystem Ephemerum Impressum AudioVideoTitle)
ignore = %w(PersonIsaar)

File.open("#{RAILS_ROOT}/data/notes_migration.csv") do |file|
  file.each_line do |line|
    arr = line.split('|')
    if arr.size == 4
      class_name, old_id, note, old_user_id = arr
      if class_name == 'Old::Alumnus'
        class_name = 'Alumnus'
      elsif class_name == 'Old::Impressum'
        class_name = 'Impressum'
      end
      if current_class_name != class_name
        print "\n[#{class_name}]" 
        current_class_name = class_name
      end
      if loaded.include?(class_name)
        print "-"
      elsif ignore.include?(class_name)
        print ":"
      else
        clazz = eval(class_name)
        obj = clazz.find_by_old_id(old_id)
        # puts obj
        if obj.present?
          user = get_user(old_user_id)
          if Postit.for(obj, user).blank?
            attach_postit(obj, note, user)
            print "+"
          else
            print '.'
          end
        end
      end
    else
      kaboem
    end
  end
end
