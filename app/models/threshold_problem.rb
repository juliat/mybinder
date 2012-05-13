class ThresholdProblem < ActiveRecord::Base
    attr_accessible :problem_type_id, :text_reference_attributes, :mod_id
  
    # Relationships
    # =================================================================================  
    belongs_to :mod
    belongs_to :problem_type
    has_one :text_reference, :as => :textbookable, :dependent => :destroy
    
    accepts_nested_attributes_for :text_reference, :allow_destroy => true
    
    # Scope
    # ================================================================================= 
    scope :by_type, order("problem_type_id")
    scope :for_type, lambda{|type| where("problem_type_id = ?", ProblemType.find_by_name(type).id)}
    
    # Methods
    # =================================================================================   
    def problem
        return "#{self.text_reference.as_string}"
    end
end
