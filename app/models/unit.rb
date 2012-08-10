class Unit < ActiveRecord::Base

    #~ t.integer :course_id
    #~ t.integer :number
    #~ t.string :name
    #~ t.date :start_date
    #~ t.date :end_date
    #~ t.integer :days
    #~ t.text :notes

    # Validations
    # =================================================================================
    # validates_presence_of :name, :start_date, :days

    attr_accessible :course_id, :number, :name, :start_date, :end_date, :days, :notes,
                    :key_concepts_attributes, :key_terms_attributes


    # Relationships
    # =================================================================================
    belongs_to :course
    has_many :key_concepts
    has_many :key_terms
    has_many :mods
    has_many :topics, :through => :mods
    has_many :goals, :through => :topics
    has_many :standards # temporary until standards are mapped to goals
    has_many :misconceptions
    
    has_many :online_resources, :as => :resourceable
        
    # accepts_nested_attributes_for :standards, :allow_destroy => true
    accepts_nested_attributes_for :key_concepts, :allow_destroy => true
    accepts_nested_attributes_for :key_terms, :allow_destroy => true
    accepts_nested_attributes_for :online_resources, :allow_destroy => true
    # accepts_nested_attributes_for :misconceptions, :allow_destroy => true
  
    # Scopes
    # =================================================================================
    scope :for_course, lambda {|course_id| where("course_id = ?", course_id) }
    scope :in_sequence, order("number")
    
    # Methods
    # ==================================================================================
    
end
