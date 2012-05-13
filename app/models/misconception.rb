class Misconception < ActiveRecord::Base

    attr_accessible :statement, :unit_id, :topic_id

    # Relationships
    # =================================================================================
    belongs_to :unit
    belongs_to :topic
    
end
