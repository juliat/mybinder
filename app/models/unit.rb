class Unit < ActiveRecord::Base

    #~ t.integer :course_id
    #~ t.string :name
    #~ t.date :start_date
    #~ t.integer :days
    #~ t.text :notes

    # Validations
    # =================================================================================
    validates_presence_of :name, :start_date, :days

    attr_accessible :course_id, :name, :start_date, :days


    # Relationships
    # =================================================================================
    belongs_to :course
    has_many :key_concepts
    has_many :key_terms
    has_many :mods
    has_many :topics, :through => :mods
    has_many :goals, :through => :topics
  
end
