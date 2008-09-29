class AddModuleHeadingHoverToColor < ActiveRecord::Migration
  def self.up
    add_column :colors, :title, :string
    add_column :colors, :module_heading_hover, :string
  end

  def self.down
    remove_column :colors, :title
    remove_column :colors, :module_heading_hover
  end
end
