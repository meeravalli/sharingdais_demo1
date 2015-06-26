class AddTrashedColumnToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :trashed, :boolean, :default => false
  end
end
