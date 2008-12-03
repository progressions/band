class AddComposerToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :composer, :string
  end

  def self.down
    remove_column :settings, :composer
  end
end
