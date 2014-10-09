class AddSkillPostRequirmentIdToRates < ActiveRecord::Migration
  def change
    add_column :rates, :skill_post_requirement_id, :integer
  end
end
