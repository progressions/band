class AddEventsToShow < ActiveRecord::Migration
  def self.up
    add_column :shows, :facebook_event, :string
    add_column :shows, :myspace_event, :string
  end

  def self.down
    remove_column :shows, :myspace_event
    remove_column :shows, :facebook_event
  end
end
