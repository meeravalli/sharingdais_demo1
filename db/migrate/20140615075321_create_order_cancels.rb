class CreateOrderCancels < ActiveRecord::Migration
  def change
    create_table :order_cancels do |t|
      t.integer :order_id
      t.date :cancel_date

      t.timestamps
    end
  end
end
