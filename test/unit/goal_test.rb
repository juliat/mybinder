require 'test_helper'

class GoalTest < ActiveSupport::TestCase
    # Validations
    should validate_presence_of(:statement)
    
    # Relationships
    should belong_to(:topic)
    should belong_to(:goal_type)
    should have_many(:standard_goal_mappings)
    should have_many(:standards).through(:standard_goal_mappings)
    
    # @TODO
    # test scope :for_topic
    
    # @TODO
    # test scope :in_order
end
