class ProblemType < ActiveRecord::Base
    attr_accessible :name

    # Relationships
    # =================================================================================
    has_many :threshold_problems
end
