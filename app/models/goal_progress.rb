class GoalProgress < ActiveRecord::Base

	attr_accessible :course_class_id, :goal_id, :completed, :notes

	# Relationships
	# =================================================================================
	belongs_to :course_class
	belongs_to :goal
	
	# Scope
	# =================================================================================
	scope :for_course_class, lambda {|course_class_id| where("course_class_id = ?", course_class_id) }
	
	# Methods
    # =================================================================================
    # class method to get all goal progresses hierarchically sorted
    # takes a list of goal_progresses
    def self.sorted(goal_progresses)
		sorted_hash = {}
		gps_sorted_by_unit = goal_progresses.to_set.classify{|gp| gp.goal.unit}
		gps_sorted_by_unit.each do |unit, gps|
			# get a hash of the topics sorted by mod
			gps_sorted_by_mod = gps.classify{|gp| gp.goal.mod}
			
			gps_sorted_by_mod.each do |mod, gps|
				# get a hash of the goals sorted by topic
				gps_sorted_by_topic = gps.classify{|gp| gp.goal.topic}
				
				# store that hash in the place of the gps in the gps_sorted_by_mod hash
				gps_sorted_by_mod[mod] = gps_sorted_by_topic
				
			end
			
			# store that hash in the place of the gps in the gps_sorted_by_unit hash
			gps_sorted_by_unit[unit] = gps_sorted_by_mod
		end
		return gps_sorted_by_unit
    end	
end
