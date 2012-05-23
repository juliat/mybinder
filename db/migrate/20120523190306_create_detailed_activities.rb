class CreateDetailedActivities < ActiveRecord::Migration
  def change
    create_table :detailed_activities do |t|
      t.string :name
      t.text :description
      t.integer :activity_id
      t.integer :user_id

      t.timestamps
    end
  end
end
