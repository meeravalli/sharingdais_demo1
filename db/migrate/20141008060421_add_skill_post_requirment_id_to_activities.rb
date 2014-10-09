class AddSkillPostRequirmentIdToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :skill_post_requirement_id, :integer
  end
end
