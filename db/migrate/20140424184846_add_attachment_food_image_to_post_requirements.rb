class AddAttachmentFoodImageToPostRequirements < ActiveRecord::Migration
  def self.up
    change_table :post_requirements do |t|
      t.attachment :food_image
    end
  end

  def self.down
    drop_attached_file :post_requirements, :food_image
  end
end
