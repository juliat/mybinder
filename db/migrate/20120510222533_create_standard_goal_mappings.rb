class CreateStandardGoalMappings < ActiveRecord::Migration
  def change
    create_table :standard_goal_mappings do |t|
      t.integer :standard_id
      t.integer :goal_id

      t.timestamps
    end
  end
end
