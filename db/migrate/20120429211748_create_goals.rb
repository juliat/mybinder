class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :statement
      t.string :goal_type
      t.integer :topic_id
      t.timestamps
    end
  end
end
