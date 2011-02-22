class PressCuttingNotAvailableByDefault < ActiveRecord::Migration
  def self.up
    change_column_default :press_cuttings, :available, false
  end

  def self.down
    change_column_default :press_cuttings, :available, true
  end
end
