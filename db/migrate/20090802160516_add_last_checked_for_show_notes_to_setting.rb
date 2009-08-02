class AddLastCheckedForShowNotesToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :last_checked_for_show_notes, :datetime
  end

  def self.down
    remove_column :settings, :last_checked_for_show_notes
  end
end
