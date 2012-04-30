class Goal < ActiveRecord::Base
    attr_accessible :goal_type_id, :statement, :topic_id

    # Validations
    # =================================================================================
    validates_presence_of :statement
    
    
    # Relationships
    # =================================================================================
    belongs_to :topic
    # has a type id

    # Scopes
    # =================================================================================
    scope :for_topic, lambda {|topic_id| where("topic_id = ?", topic_id) }

end
