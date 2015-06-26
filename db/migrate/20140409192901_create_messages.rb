class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :user_id
      t.integer :posted_to
      t.boolean :read, :default => false

      t.timestamps
    end
  end
end
