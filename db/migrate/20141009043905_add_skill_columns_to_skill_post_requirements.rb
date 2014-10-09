class AddSkillColumnsToSkillPostRequirements < ActiveRecord::Migration
  def self.up
    add_attachment :skill_post_requirements, :skill
  end
  def self.down
    remove_attachment :skill_post_requirements, :skill
  end
end
