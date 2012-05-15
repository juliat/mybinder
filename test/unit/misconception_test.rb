require 'test_helper'

class MisconceptionTest < ActiveSupport::TestCase
    # Validations
    should validate_presence_of(:statement)
    
    # Relationships
    should belong_to(:unit)
    # should belong_to(:topic) ... eventually
    
    # test custom validation that ensures that when misconceptions are mapped to those
    # topics, those topics belong to the unit that the misconception belongs_to
    
end
