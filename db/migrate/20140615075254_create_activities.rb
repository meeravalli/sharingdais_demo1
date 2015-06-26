class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.integer :contact_id
      t.integer :order_id
      t.integer :post_requirement_id
      t.boolean :seeked_shared, :default => false
      t.timestamps
    end
  end
end
