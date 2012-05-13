class Mod < ActiveRecord::Base

    attr_accessible :number, :days, :unit_id, :notes

  
    # Relationships
    # =================================================================================
    # has_many threshold_problems
    # has_many threshold_equations
    belongs_to :unit
    has_many :topics
    has_many :goals, :through =>  :topics
    has_many :activities, :through => :topics
    # has_many :misconceptions
    
    # Scopes
    # =================================================================================
    scope :for_unit, lambda {|unit_id| where("unit_id = ?", unit_id) }
end
