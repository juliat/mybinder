require 'test_helper'

class TextReferenceTest < ActiveSupport::TestCase

    should belong_to(:textbookable)
    
    context "Creating text references" do
        setup do
            @textRef = FactoryGirl.create(:text_reference, :book => "Textbook", :location => "p. 42")
        end
        
        teardown do
            @textRef.destroy
        end
        
        should "show that the text reference as string method works" do
            assert_equal "Textbook p. 42", @textRef.as_string
        end
    end

end


