class AddPromoIdToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :promo_id, :integer
  end

  def self.down
    remove_column :settings, :promo_id
  end
end
