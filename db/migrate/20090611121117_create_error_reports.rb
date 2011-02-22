class CreateErrorReports < ActiveRecord::Migration
  def self.up
    create_table :error_reports do |t|
      t.integer :error_reportable_id
      t.string :error_reportable_type
      t.string :message, :limit => 2500
      t.boolean :fixed, :default => false
      
      t.userstamps
      t.timestamps
    end
  end

  def self.down
    drop_table :error_reports
  end
end
