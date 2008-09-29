class CreateVenues < ActiveRecord::Migration
  def self.up
    create_table :venues do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :city
      t.string :state
      t.integer :zipcode
      t.string :website
      t.string :phone

      t.timestamps
    end
    
    add_column :shows, :venue_id, :integer
    remove_column :shows, :venue
  end

  def self.down
    drop_table :venues
    remove_column :shows, :venue_id
    add_column :shows, :venue, :string
  end
end
