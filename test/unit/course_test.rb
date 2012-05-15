require 'test_helper'

class CourseTest < ActiveSupport::TestCase
    # Validations
    should validate_presence_of(:name)
    should validate_presence_of(:description)
    
    # Relationships
    should have_many(:units)
    should have_many(:modules).through(:units)
    should have_many(:topics).through(:modules)
    should have_many(:resourceable)
end
