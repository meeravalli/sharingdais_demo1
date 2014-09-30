class AddNegoIdToBookNegotiates < ActiveRecord::Migration
  def change
    add_column :book_negotiates, :nego_id, :integer
  end
end
