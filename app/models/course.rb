class Course < ActiveRecord::Base
    attr_accessible :description, :name 

    # Validations
    # =================================================================================
    validates_presence_of :name, :description

    # Relationships
    # =================================================================================
    has_many :units
    has_many :mods, :through => :units
    has_many :topics, :through => :mods
    has_many :goals, :through => :topics
    has_many :online_resources, :as => :resourceable
    has_many :course_classes
    has_many :teachers, :through => :course_classes
    
    # Methods
    # =================================================================================
end
