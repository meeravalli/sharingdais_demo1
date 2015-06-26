class AddFieldsToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :food, :string
    add_column :messages, :location, :string
    add_column :messages, :order_id, :integer
  end
end
