class ThresholdProblem < ActiveRecord::Base
    attr_accessible :problem_type_id, :name, :text_reference_attributes
  
    # Relationships
    # =================================================================================  
    has_one :text_reference, :as => :textbookable, :dependent => :destroy
    
    accepts_nested_attributes_for :text_reference, :allow_destroy => true
    
end
