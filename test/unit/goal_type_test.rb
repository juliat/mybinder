require 'test_helper'

class GoalTypeTest < ActiveSupport::TestCase
    # Validations
    should validate_presence_of(:name)
   
    # Relationships
    should have_many(:goals)
end
