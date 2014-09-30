class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.references :negotiate
      t.references :book_negotiate
      t.references :user
      t.integer :rated_id
      t.references :post_requirement
      t.references :book_post_requirement
      t.integer :rated_no
      t.string :service_type

      t.timestamps
    end
    add_index :rates, :negotiate_id
    add_index :rates, :book_negotiate_id
    add_index :rates, :user_id
    add_index :rates, :post_requirement_id
    add_index :rates, :book_post_requirement_id
  end
end
