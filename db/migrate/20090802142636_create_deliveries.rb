class CreateDeliveries < ActiveRecord::Migration
  def self.up
    create_table :deliveries do |t|
      t.integer :mail_id
      t.integer :fan_count

      t.timestamps
    end
  end

  def self.down
    drop_table :deliveries
  end
end
