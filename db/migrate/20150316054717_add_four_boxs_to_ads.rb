class AddFourBoxsToAds < ActiveRecord::Migration
  def change
    add_column :ads, :box_17, :integer
    add_column :ads, :box_18, :integer
    add_column :ads, :box_19, :integer
    add_column :ads, :box_20, :integer
  end
end
