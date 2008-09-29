class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :name
      t.string :url
      t.text :body
      t.boolean :active, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :page
  end
end
