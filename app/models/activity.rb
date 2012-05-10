class Activity < ActiveRecord::Base
    
    attr_accessible :name, :prior_knowledge, :rationale, :topic_id
   
    # Validations
    # =================================================================================
    validates_presence_of :name, :rationale
    
    
    # Relationships
    # =================================================================================
    belongs_to :topic
  
end
