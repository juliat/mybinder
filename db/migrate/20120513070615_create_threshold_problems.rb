class CreateThresholdProblems < ActiveRecord::Migration
  def change
    create_table :threshold_problems do |t|
      t.integer :problem_type_id
      t.integer :mod_id
      
      t.timestamps
    end
  end
end
