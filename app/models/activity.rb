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
    
    # make resourceable
    has_many :online_resources, :as => :resourceable
    accepts_nested_attributes_for :online_resources, :allow_destroy => true
  
end
