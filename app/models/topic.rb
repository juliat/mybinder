class Topic < ActiveRecord::Base
    attr_accessible :mod_id, :name

    # Relationships
    # ==============================================================================
    belongs_to :mod
    has_many :goals
    has_many :misconceptions
    # has_many standards
    has_many :activities

    # Scopes
    # ==============================================================================
    scope :for_mod, lambda {|mod_id| where("mod_id = ?", mod_id) }
end
