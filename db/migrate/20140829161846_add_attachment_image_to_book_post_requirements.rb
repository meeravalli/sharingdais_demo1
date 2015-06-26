class AddAttachmentImageToBookPostRequirements < ActiveRecord::Migration
  def self.up
    change_table :book_post_requirements do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :book_post_requirements, :image
  end
end
