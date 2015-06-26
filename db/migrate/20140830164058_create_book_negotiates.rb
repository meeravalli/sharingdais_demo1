class CreateBookNegotiates < ActiveRecord::Migration
  def change
    create_table :book_negotiates do |t|
      t.integer :book_post_requirement_id
      t.integer :user_id

      t.timestamps
    end
  end
end
