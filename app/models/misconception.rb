class Misconception < ActiveRecord::Base

    attr_accessible :statement, :unit_id, :topic_id
    
    # Validations
    # =================================================================================
    # validate that topic belongs to unit (unit relation is technically temporary, so we
    # want to make sure that misconceptions eventually get mapped to topics that are
    # within the unit they are currently in
    validates_presence_of :statement
    validate :topic_belongs_to_unit, :on => :save
    
    # Relationships
    # =================================================================================
    belongs_to :unit
    belongs_to :topic
    
    # Methods
    # =================================================================================
    private
    # custom validation
    def topic_belongs_to_unit
        units_topics = self.unit.topics
        unless units_topics.include?(self.topic_id)
            errors.add(:topic_id, "is not part of this unit")
        end
    end
       
end
