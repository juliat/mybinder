class AuthorOrg < ActiveRecord::Base
    attr_accessible :name

    # Validations
    # =================================================================================
    validates_presence_of :name


    # Relationships
    # =================================================================================
    has_many :standards
    
end
