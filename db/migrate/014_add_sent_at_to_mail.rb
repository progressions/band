class AddSentAtToMail < ActiveRecord::Migration
  def self.up
    add_column :mails, :sent_at, :datetime
  end

  def self.down
    remove_column :mails, :sent_at
  end
end
