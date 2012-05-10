class GoalType < ActiveRecord::Base
    attr_accessible :description, :name
    
    # Validations
    # =================================================================================
    validates_presence_of :name
    
    
    # Relationships
    # =================================================================================
    has_many :goals
    
end
