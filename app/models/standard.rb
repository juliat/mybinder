class Standard < ActiveRecord::Base
   
    attr_accessible :author_org_id, :author_org_code, :statement, :unit_id

    # Validations
    # =================================================================================
    validates_presence_of :statement


    # Relationships
    # =================================================================================
    has_many :standard_goal_mappings
    has_many :goals, :through => :standard_goal_mappings
    belongs_to :author_org
    belongs_to :unit # temporary until standards are mapped to goals
end
