require 'test_helper'

class AuthorOrgTest < ActiveSupport::TestCase
    # Validations
    should validate_presence_of(:name)
    
    # Relationships
    should have_many(:standards)
end
