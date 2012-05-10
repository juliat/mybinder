# many to many association table for standards and goals

class StandardGoalMapping < ActiveRecord::Base
    attr_accessible :goal_id, :standard_id

    # Relationships
    # =================================================================================
    belongs_to :goal
    belongs_to :standard
end
