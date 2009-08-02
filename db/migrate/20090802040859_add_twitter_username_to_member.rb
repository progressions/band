class AddTwitterUsernameToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :twitter_username, :string
    add_column :members, :twitter_password, :string
  end

  def self.down
    remove_column :members, :twitter_password
    remove_column :members, :twitter_username
  end
end
