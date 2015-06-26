class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :service_type
      t.timestamps
    end
  end
end
