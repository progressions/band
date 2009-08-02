class AddUseCaptchaForFansToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :use_captcha_for_fans, :boolean
  end

  def self.down
    remove_column :settings, :use_captcha_for_fans
  end
end
