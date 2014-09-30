class AddNegoIdToNegotiates < ActiveRecord::Migration
  def change
    add_column :negotiates, :nego_id, :integer
  end
end
