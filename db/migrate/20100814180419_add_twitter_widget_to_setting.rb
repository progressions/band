class AddTwitterWidgetToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :twitter_widget, :string
  end

  def self.down
    remove_column :settings, :twitter_widget
  end
end
