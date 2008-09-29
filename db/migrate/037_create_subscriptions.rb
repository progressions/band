class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.integer :blog_id
      t.string :email
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :subscriptions
  end
end
