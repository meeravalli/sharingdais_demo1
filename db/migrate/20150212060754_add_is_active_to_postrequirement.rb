class AddIsActiveToPostrequirement < ActiveRecord::Migration
  def change
  	add_column :post_requirements, :is_active, :boolean, :default => true
  end
end
