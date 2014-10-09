class AddSkillPostRequirmentIdToNegotiates < ActiveRecord::Migration
  def change
    add_column :negotiates, :skill_post_requirement_id, :integer
  end
end
