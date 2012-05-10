class KeyTerm < ActiveRecord::Base
   
    attr_accessible :term, :unit_id
    # Validations
    # =================================================================================
    validates_presence_of :term


    # Relationships
    # =================================================================================
    belongs_to :unit

end
