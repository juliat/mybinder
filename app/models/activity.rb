class Activity < ActiveRecord::Base
    
    attr_accessible :name, :prior_knowledge, :rationale, :topic_id, :detailed_activities_attributes
      
    # Validations
    # =================================================================================
    validates_presence_of :name, :rationale, :prior_knowledge
    
    # no validations for format
    
    # Relationships
    # =================================================================================
    belongs_to :topic
    has_many :detailed_activities
    accepts_nested_attributes_for :detailed_activities
    
    # make resourceable
    has_many :online_resources, :as => :resourceable
    accepts_nested_attributes_for :online_resources, :allow_destroy => true
  
end
