class Goal < ActiveRecord::Base
    attr_accessible :goal_type_id, :statement, :topic_id, :number

    # Validations
    # =================================================================================
    validates_presence_of :statement


    # Relationships
    # =================================================================================
    belongs_to :topic
    belongs_to :goal_type
    has_many :standard_goal_mappings
    has_many :standards, :through => :standard_goal_mappings
    has_many :goal_progresses
    # has a type id

    # Scopes
    # =================================================================================
    scope :for_topic, lambda {|topic_id| where("topic_id = ?", topic_id) }
    scope :in_sequential_order, order("number")
    
    # Methods
    # =================================================================================
    # get the module for this goal
    def mod
		self.topic.mod
	end
	
	# get the unit for this goal
	def unit
		self.topic.mod.unit
	end
	
	# get the course for this goal
	def course
		self.topic.mod.unit.course
	end
	
	
    # class method to get all goals hierarchically sorted
    # takes a list of goals
    # **** THIS IS REDUNDANT with similar method in goal_progress.rb model. TODO: factor out, somehow
    def self.sorted(goals)
		sorted_hash = {}
		goals_sorted_by_unit = goals.to_set.classify{|goal| goal.unit}
		goals_sorted_by_unit.each do |unit, goals|
			# get a hash of the topics sorted by mod
			goals_sorted_by_mod = goals.classify{|goal| goal.mod}
			
			goals_sorted_by_mod.each do |mod, goals|
				# get a hash of the goals sorted by topic
				goals_sorted_by_topic = goals.classify{|goal| goal.topic}
				
				# store that hash in the place of the goals in the goals_sorted_by_mod hash
				goals_sorted_by_mod[mod] = goals_sorted_by_topic
				
			end
			
			# store that hash in the place of the goals in the goals_sorted_by_unit hash
			goals_sorted_by_unit[unit] = goals_sorted_by_mod
		end
		return goals_sorted_by_unit
    end	
        
end
