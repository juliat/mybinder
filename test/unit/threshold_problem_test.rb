require 'test_helper'

class ThresholdProblemTest < ActiveSupport::TestCase

    should belong_to(:mod)
    should belong_to(:problem_type)
    should have_one(:text_reference)

    context "Creating threshold problems" do
        setup do
            @textRef = FactoryGirl.create(:text_reference, :book => "Textbook", :location => "p. 42")
            @thresholdProblem = FactoryGirl.create(:threshold_problem, :text_reference => @textRef)
        end
        
        teardown do
            @textRef.destroy
            @thresholdProblem.destroy
        end
        
        should "show that the problem method returns the associated text reference as a string" do
            assert_equal "Textbook p. 42", @thresholdProblem.problem
        end
        
    end
end
