class Activity < ActiveRecord::Base
    attr_accessible :name, :prior_knowledge, :rationale, :topic_id

    # Relationships
    # =================================================================================
    belongs_to :topic
  
end
