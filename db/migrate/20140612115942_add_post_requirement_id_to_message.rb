class AddPostRequirementIdToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :post_requirement_id, :integer
  end
end
