class CreateNegotiates < ActiveRecord::Migration
  def change
    create_table :negotiates do |t|
      t.integer :post_requirement_id
      t.string  :user_id
      t.timestamps
    end
  end
end
