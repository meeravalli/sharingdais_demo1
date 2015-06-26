class CreateBookMessages < ActiveRecord::Migration
  def change
    create_table :book_messages do |t|
      t.integer :user_id
      t.integer :posted_to
      t.text :content
      t.boolean :read
      t.string :subject
      t.boolean :order_status
      t.boolean :accepted
      t.boolean :trashed
      t.integer :book_post_requirement_id
      t.integer :location_id
      t.integer :book_order_id

      t.timestamps
    end
  end
end
