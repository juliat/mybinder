require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
    # Test relationships
    should belong_to(:topic)
    should have_many(:documents)

    # Test validations
    should validate_presence_of(:name)
    should validate_presence_of(:rationale)
    should validate_presence_of(:prior_knowledge)
end
