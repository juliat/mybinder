require 'test_helper'

class KeyTermTest < ActiveSupport::TestCase
    # Validations
    should validate_presence_of(:term)
    
    # Relationships
    should belong_to(:unit)
end
