require 'test_helper'

class ModTest < ActiveSupport::TestCase
    # Validations
    should validate_numericality_of(:number)
    should validate_numericality_of(:days)
    
    # Relationships
    should belong_to(:unit)
    should have_many(:equations)
    should have_many(:threshold_problems)
    should have_many(:textbookable)
    should have_many(:topics)
    should have_many(:goals)
    should have_many(:activities)
        
    # Context
        # test scope :for_unit
        # test method :sorted_threshold_problems
end
