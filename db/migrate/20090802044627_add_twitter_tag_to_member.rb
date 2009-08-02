class AddTwitterTagToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :twitter_tag, :string
  end

  def self.down
    remove_column :members, :twitter_tag
  end
end
