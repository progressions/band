class AddPasswordToTwitterProfile < ActiveRecord::Migration
  def self.up
    add_column :settings, :twitter_password, :string
  end

  def self.down
    remove_column :settings, :twitter_password
  end
end
