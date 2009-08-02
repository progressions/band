class AddActiveToFan < ActiveRecord::Migration
  def self.up
    add_column :fans, :active, :boolean
    add_column :fans, :unsubscribed_at, :datetime
  end

  def self.down
    remove_column :fans, :unsubscribed_at
    remove_column :fans, :active
  end
end
