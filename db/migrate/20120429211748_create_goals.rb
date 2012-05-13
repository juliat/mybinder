class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :statement
      t.integer :number
      t.integer :goal_type_id
      t.integer :topic_id
      t.timestamps
    end
  end
end
