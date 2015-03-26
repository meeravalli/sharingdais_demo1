class CreatePeerCategories < ActiveRecord::Migration
  def change
    create_table :peer_categories do |t|
      t.string :peer_category_type

      t.timestamps
    end
  end
end
