class Goal < ActiveRecord::Base
    attr_accessible :goal_type_id, :statement, :topic_id, :number

    # Validations
    # =================================================================================
    validates_presence_of :statement


    # Relationships
    # =================================================================================
    belongs_to :topic
    belongs_to :goal_type
    has_many :standard_goal_mappings
    # has a type id

    # Scopes
    # =================================================================================
    scope :for_topic, lambda {|topic_id| where("topic_id = ?", topic_id) }

end
