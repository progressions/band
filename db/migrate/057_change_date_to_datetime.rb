class ChangeDateToDatetime < ActiveRecord::Migration
  def self.up
    change_column :shows, :date, :datetime
  end

  def self.down
    change_column :shows, :datetime, :date
  end
end
