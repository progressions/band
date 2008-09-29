class AddCryptedEmailToFan < ActiveRecord::Migration
  def self.up
    add_column :fans, :crypted_email, :string
  end

  def self.down
    remove_column :fans, :crypted_email
  end
end
