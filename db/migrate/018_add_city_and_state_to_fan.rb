class AddCityAndStateToFan < ActiveRecord::Migration
  def self.up
    add_column :fans, :city, :string
    add_column :fans, :state, :string
  end

  def self.down
    remove_column :fans, :state
    remove_column :fans, :city
  end
end
