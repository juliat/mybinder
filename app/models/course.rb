class Course < ActiveRecord::Base
    attr_accessible :description, :name

    # Validations
    # =================================================================================
    validates_presence_of :name, :description

    # Relationships
    has_many :units

end
