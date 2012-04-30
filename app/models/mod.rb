class Mod < ActiveRecord::Base

    attr_accessible :days, :unit_id

  
    # Relationships
    # =================================================================================
    # has_many threshold_problems
    # has_many threshold_equations
    belongs_to :unit
    has_many :topics
    has_many :goals, :through =>  :topics
    has_many :activities, :through => :topics
    # has_many :misconceptions
  
end
