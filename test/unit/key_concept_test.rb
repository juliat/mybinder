require 'test_helper'

class KeyConceptTest < ActiveSupport::TestCase
    # Validations
    should validate_presence_of(:statement)
    
    # Relationships
    should belong_to(:unit)
end
