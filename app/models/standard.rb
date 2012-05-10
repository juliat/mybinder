class Standard < ActiveRecord::Base
   
    attr_accessible :author_org_id, :author_org_code, :statement

    # Validations
    # =================================================================================
    validates_presence_of :statement


    # Relationships
    # =================================================================================
    has_many :standard_goal_mappings
    belongs_to :author_org
    
end
