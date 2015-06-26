class CreateBookOrders < ActiveRecord::Migration
  def change
    create_table :book_orders do |t|
      t.integer :user_id
      t.integer :provider_id
      t.integer :book_post_requirement_id
      t.date :order_date

      t.timestamps
    end
  end
end
