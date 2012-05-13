class ProblemType < ActiveRecord::Base
    attr_accessible :name

    # Validations
    # =================================================================================
    validates_uniqueness_of :name


    # Relationships
    # =================================================================================
    has_many :threshold_problems
end
