class Goal < ActiveRecord::Base
  attr_accessible :goal_type, :statement, :topic_id
  
  # Relationships
  belongs_to :topic
  
  # Constants
  GOAL_TYPES_LIST = [['Content Expectation', 'ce'],['Performance Expectation', 'pe']]
  
end
