class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.integer :box_1
      t.integer :box_2
      t.integer :box_3
      t.integer :box_4
      t.integer :box_5
      t.integer :box_6
      t.integer :box_7
      t.integer :box_8
      t.integer :box_9
      t.integer :box_10
      t.string :ip

      t.timestamps
    end
  end
end
