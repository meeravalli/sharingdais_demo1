class ChangeBudgetFormatInPostRequirements < ActiveRecord::Migration
  def up
   change_column :post_requirements, :budget, :decimal, :precision => 8, :scale => 2
  end

end
