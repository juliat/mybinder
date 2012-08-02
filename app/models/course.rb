class Course < ActiveRecord::Base
    attr_accessible :description, :name 

    # Validations
    # =================================================================================
    validates_presence_of :name, :description

    # Relationships
    has_many :units
    has_many :modules, :through => :units
    has_many :topics, :through => :modules
    has_many :goals, :through => :topics
    has_many :online_resources, :as => :resourceable
end
