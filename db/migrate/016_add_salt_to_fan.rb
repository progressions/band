class AddSaltToFan < ActiveRecord::Migration
  def self.up
    add_column :fans, :salt, :string
  end

  def self.down
    remove_column :fans, :salt
  end
end
