class AddSkillPostRequirmentIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :skill_post_requirement_id, :integer
  end
end
