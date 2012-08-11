class CreateGoalProgresses < ActiveRecord::Migration
  def change
    create_table :goal_progresses do |t|
      t.integer :goal_id
      t.integer :course_class_id
      t.boolean :completed, :default => true
      t.text :notes

      t.timestamps
    end
  end
end
