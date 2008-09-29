class AddCreatedByToMail < ActiveRecord::Migration
  def self.up
    add_column :mails, :created_by, :integer
  end

  def self.down
    remove_column :mails, :created_by
  end
end
