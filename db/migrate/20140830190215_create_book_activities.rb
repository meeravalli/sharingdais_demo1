class CreateBookActivities < ActiveRecord::Migration
  def change
    create_table :book_activities do |t|
      t.integer :user_id
      t.integer :contact_id
      t.integer :book_order_id
      t.integer :book_post_requirement_id
      t.boolean :seeked_shared, default: false

      t.timestamps
    end
  end
end
