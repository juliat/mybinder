class ActivityGoal < ActiveRecord::Base
	attr_accessible :activity_id, :goal_id
  
	# Relationships
	# =================================================================================
	belongs_to :activity
	belongs_to :goal
end
