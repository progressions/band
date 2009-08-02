class AddNicknameToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :nickname, :string
  end

  def self.down
    remove_column :members, :nickname
  end
end
