class RemoveColor < ActiveRecord::Migration
  def self.up
    drop_table :colors
  end

  def self.down
    create_table :colors do |t|
      t.string :body
      t.string :heading
      t.string :news_heading
      t.string :link
      t.string :link_visited
      t.string :link_hover
      t.string :utility
      t.string :main_bg
      t.string :sidebar_bg
      t.string :module_bg
      t.string :module_heading
      t.string :module_heading_bg
      t.string :module_heading_bg_hover
      t.string :footer
      t.string :footer_link
      t.string :footer_bg

      t.timestamps    
  end
end
