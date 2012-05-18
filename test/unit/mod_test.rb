require 'test_helper'

class ModTest < ActiveSupport::TestCase
    # Validations
    should validate_numericality_of(:number)
    should validate_numericality_of(:days)
    
    # Relationships
    should belong_to(:unit)
    should have_many(:equations)
    should have_many(:threshold_problems)
    should have_many(:text_references) # as textbookable    
    should have_many(:topics)
    should have_many(:goals)
    should have_many(:activities)
        
    # Context
    context "Creating a module and associated things" do
        setup do
            @unit1 = FactoryGirl.create(:unit)
            @unit2 = FactoryGirl.create(:unit, :name => "Another Unit", :number => 2)
            @mod1 = FactoryGirl.create(:mod, :unit => @unit1)
            @mod2 = FactoryGirl.create(:mod, :unit => @unit2)
            @problem_type_1 = FactoryGirl.create(:problem_type, :name => "Conceptual")
            @problem_type_2 = FactoryGirl.create(:problem_type, :name => "Computational")
            @prob1 = FactoryGirl.create(:threshold_problem, :mod => @mod1, :problem_type => @problem_type_1)
            @prob2 = FactoryGirl.create(:threshold_problem, :mod => @mod1, :problem_type => @problem_type_2)
            @prob3 = FactoryGirl.create(:threshold_problem, :mod => @mod1, :problem_type => @problem_type_1)
            @prob4 = FactoryGirl.create(:threshold_problem, :mod => @mod1, :problem_type => @problem_type_2)
        end
        
        #~ teardown do
            #~ @unit.destroy
            #~ @mod.destroy
            #~ @problem_type_1.destroy
            #~ @problem_type_2.destroy
            #~ @prob1.destroy
            #~ @prob2.destroy
            #~ @prob3.destroy
            #~ @prob4.destroy
        #~ end
        
        should "show that the for_unit scope returns modules associated with the given unit" do
            assert_equal Mod.for_unit(@unit1.id), [@mod1]
            assert_equal Mod.for_unit(@unit2.id), [@mod2]
        end
        
        should "show that the sorted threshold problems method returns a hash mapping problem type names to lists of problems of that type" do
            correct_hash = {"Conceptual" => [@prob1, @prob3], 
                            "Computational" => [@prob2, @prob4]
                            }
            assert_equal correct_hash, @mod1.sorted_threshold_problems
        end
    end
end
