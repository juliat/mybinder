class Mod < ActiveRecord::Base

    attr_accessible :number, :days, :unit_id, :notes, :text_reference_attributes

  
    # Relationships
    # =================================================================================
    has_many :threshold_problems
    has_many :text_references, :as => :textbookable, :dependent => :destroy
    belongs_to :unit
    has_many :topics
    has_many :goals, :through =>  :topics
    has_many :activities, :through => :topics
    # has_many :misconceptions
    
    accepts_nested_attributes_for :text_references, :allow_destroy => true
    
    # Scopes
    # =================================================================================
    scope :for_unit, lambda {|unit_id| where("unit_id = ?", unit_id) }
end
