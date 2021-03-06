class Topic < ActiveRecord::Base
    attr_accessible :mod_id, :name, :number

    # Relationships
    # ==============================================================================
    belongs_to :mod
    has_many :goals
    has_many :standard_goal_mappings, :through => :goals
    has_many :standards, :through => :standard_goal_mappings
    has_many :misconceptions
    # has_many standards
    has_many :activities
    
    # make resourceable
    has_many :online_resources, :as => :resourceable
    accepts_nested_attributes_for :online_resources, :allow_destroy => true

    # Scopes
    # ==============================================================================
    scope :for_mod, lambda {|mod_id| where("mod_id = ?", mod_id) }
    scope :in_order, order("number")
    
    # Methods
    # ============================================================================== 
    def unit
		return self.mod.unit
	end
end
