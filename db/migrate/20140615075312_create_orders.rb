class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :provider_id
      t.integer :post_requirement_id
      t.date :order_date 

    end
  end
end
