class AddEndTimeToShow < ActiveRecord::Migration
  def self.up
    add_column :shows, :end_time, :time
  end

  def self.down
    remove_column :shows, :end_time
  end
end
