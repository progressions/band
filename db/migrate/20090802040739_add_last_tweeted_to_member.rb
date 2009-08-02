class AddLastTweetedToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :last_tweeted, :datetime
  end

  def self.down
    remove_column :members, :last_tweeted
  end
end
