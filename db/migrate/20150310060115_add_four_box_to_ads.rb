class AddFourBoxToAds < ActiveRecord::Migration
  def change
    add_column :ads, :box_13, :integer
    add_column :ads, :box_14, :integer
    add_column :ads, :box_15, :integer
    add_column :ads, :box_16, :integer
  end
end
