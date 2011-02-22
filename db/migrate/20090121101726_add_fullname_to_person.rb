class AddFullnameToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :name, :string
    execute("CREATE INDEX trgm_people_name_idx ON people USING gist (name gist_trgm_ops)")
  end

  def self.down
    execute("DROP INDEX trgm_people_name_idx")
    remove_column :people, :name
  end
end
