class CreateShowRatings < ActiveRecord::Migration
  def self.up
    create_table :show_ratings do |t|
      t.integer :show_id
      t.integer :rating

      t.integer :created_by
      t.timestamps
    end
  end

  def self.down
    drop_table :show_ratings
  end
end
