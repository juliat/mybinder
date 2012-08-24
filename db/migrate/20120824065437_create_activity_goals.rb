class CreateActivityGoals < ActiveRecord::Migration
  def change
    create_table :activity_goals do |t|
      t.integer :activity_id
      t.integer :goal_id

      t.timestamps
    end
  end
end
