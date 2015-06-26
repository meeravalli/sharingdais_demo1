class CreateBookOrderCancels < ActiveRecord::Migration
  def change
    create_table :book_order_cancels do |t|
      t.integer :book_order_id
      t.date :cancel_date

      t.timestamps
    end
  end
end
