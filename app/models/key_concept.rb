class KeyConcept < ActiveRecord::Base
    attr_accessible :number, :statement
    
    # Validations
    # =================================================================================
    validates_presence_of :statement


    # Relationships
    # =================================================================================
    belongs_to :unit

end
