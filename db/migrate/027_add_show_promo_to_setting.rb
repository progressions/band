class AddShowPromoToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :show_promo, :boolean
  end

  def self.down
    remove_column :settings, :show_promo
  end
end
