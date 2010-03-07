class AddActiveToEntry < ActiveRecord::Migration
  def self.up
    add_column :entries, :active, :boolean
  end

  def self.down
    remove_column :entries, :active
  end
end
