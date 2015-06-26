class AddAcceptedMessage < ActiveRecord::Migration
  def change
    add_column :messages, :order_status, :boolean, :default => false
    add_column :messages, :accepted, :boolean, :default => false
  end
end
