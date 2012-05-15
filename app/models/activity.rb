class Activity < ActiveRecord::Base
    
    attr_accessible :name, :prior_knowledge, :rationale, :topic_id, :documents_attributes
      
    # Validations
    # =================================================================================
    validates_presence_of :name, :rationale, :prior_knowledge
    
    # no validations for format
    
    # Relationships
    # =================================================================================
    belongs_to :topic
    has_many :documents, :as => :documentable, :dependent => :destroy
    
    accepts_nested_attributes_for :documents, :allow_destroy => true
  
end
