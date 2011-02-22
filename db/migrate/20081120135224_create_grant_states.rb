class CreateGrantStates < ActiveRecord::Migration
  def self.up
    create_table :grant_states do |t|
      t.string :description

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :grant_states
  end
end
