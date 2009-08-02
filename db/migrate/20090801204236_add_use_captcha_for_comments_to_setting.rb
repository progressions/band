class AddUseCaptchaForCommentsToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :use_captcha_for_comments, :boolean
  end

  def self.down
    remove_column :settings, :use_captcha_for_comments
  end
end
