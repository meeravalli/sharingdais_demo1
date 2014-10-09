class AddSkillPostRequirmentIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :skill_post_requirement_id, :integer
  end
end
