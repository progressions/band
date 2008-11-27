class AddShowTwitterToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :show_twitter, :boolean
  end

  def self.down
    remove_column :settings, :show_twitter
  end
end
