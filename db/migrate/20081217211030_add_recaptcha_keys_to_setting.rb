class AddRecaptchaKeysToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :recaptcha_public_key, :string
    add_column :settings, :recaptcha_private_key, :string
  end

  def self.down
    remove_column :settings, :recaptcha_private_key
    remove_column :settings, :recaptcha_public_key
  end
end
