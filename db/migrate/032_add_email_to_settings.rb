class AddEmailToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :email, :string
  end

  def self.down
    remove_column :settings, :email
  end
end
