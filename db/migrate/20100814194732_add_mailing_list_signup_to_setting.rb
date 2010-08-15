class AddMailingListSignupToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :mailing_list_signup, :string
  end

  def self.down
    remove_column :settings, :mailing_list_signup
  end
end
