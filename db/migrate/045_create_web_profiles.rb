class CreateWebProfiles < ActiveRecord::Migration
  def self.up
    create_table :web_profiles do |t|
      t.string :name
      t.string :url
      t.string :image
      t.integer :setting_id

      t.timestamps
    end
  end

  def self.down
    drop_table :web_profiles
  end
end
