class CreateGrantStatuses < ActiveRecord::Migration
  def self.up
    create_table :grant_statuses do |t|
      t.string :code
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :grant_statuses
  end
end
