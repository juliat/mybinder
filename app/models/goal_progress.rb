class GoalProgress < ActiveRecord::Base
  attr_accessible :completed, :course_class_id, :goal_id, :notes
end
