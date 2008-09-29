class CreateShows < ActiveRecord::Migration
  def self.up
    create_table :shows do |t|
      t.string :title
      t.string :body
      t.date :date
      t.time :time
      t.string :venue
      t.string :address
      t.string :city
      t.string :state
      t.integer :zipcode
      t.integer :created_by

      t.timestamps
    end
  end

  def self.down
    drop_table :shows
  end
end
