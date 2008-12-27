class CreateStyles < ActiveRecord::Migration
  def self.up
    create_table :styles do |t|
      t.string   "title", :default => "Untitled Styles"
      t.string   "body"
      t.string   "heading"
      t.string   "news_heading"
      t.string   "link"
      t.string   "link_visited"
      t.string   "link_hover"
      t.string   "utility"
      t.string   "main_bg"
      t.string   "sidebar_bg"
      t.string   "module_bg"
      t.string   "module_heading"
      t.string   "module_heading_bg"
      t.string   "module_heading_hover"
      t.string   "module_heading_bg_hover"
      t.string   "footer"
      t.string   "footer_link"
      t.string   "footer_bg"
      t.integer  "setting_id"
      t.integer  "created_by"
  
      t.timestamps
    end
  end

  def self.down
    drop_table :styles
  end
end
