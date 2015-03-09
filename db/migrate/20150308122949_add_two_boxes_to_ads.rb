class AddTwoBoxesToAds < ActiveRecord::Migration
  def change
    add_column :ads, :box_11, :integer
    add_column :ads, :box_12, :integer
  end
end
