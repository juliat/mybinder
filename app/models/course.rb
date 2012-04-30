class Course < ActiveRecord::Base
    attr_accessible :description, :name, :notes

    # Validations
    # =================================================================================
    validates_presence_of :name, :description

    # Relationships
    has_many :units

end
