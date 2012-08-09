class GoalProgress < ActiveRecord::Base
 
  attr_accessible :course_class_id, :goal_id, :completed, :notes
  
  # Relationships
  # =================================================================================
  belongs_to :course_class
  belongs_to :goal
  
end
