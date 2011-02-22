class AddOldIdToPerson < ActiveRecord::Migration
  def self.up
    clazz = Person
    
    add_to_clazz(clazz)
    if clazz.respond_to? 'versioned_class'
      add_to_clazz(clazz.versioned_class)
    end
  end
  
  def self.add_to_clazz(clazz)
    unless clazz.column_names.include?('old_id')
      add_column clazz.table_name, :old_id, :integer
    end
  end

  def self.down
    remove_column :people, :old_id
  end
end
