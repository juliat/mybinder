class Unit < ActiveRecord::Base

    #~ t.integer :course_id
    #~ t.string :name
    #~ t.date :start_date
    #~ t.integer :days
    #~ t.text :notes

    # Validations
    # =================================================================================
    validates_presence_of :name, :start_date, :days

    attr_accessible :course_id, :number, :name, :start_date, :days, :notes


    # Relationships
    # =================================================================================
    belongs_to :course
    has_many :key_concepts
    has_many :key_terms
    has_many :mods
    has_many :topics, :through => :mods
    has_many :goals, :through => :topics
  
    # Scopes
    # =================================================================================
    scope :for_course, lambda {|course_id| where("course_id = ?", course_id) }
    
    
    
    # Methods
    # ==================================================================================
    def readfile
        file = File.open("public/data/curric/physics_unit_1.txt", "r")
        file.each do |line|
            if self.number.nil?
                u_indx = line.index("Unit")
                stop = line.index(":")
                u_num = line.slice(uindx + 4, stop)
                self.number = u_num
                puts u_num
            end
        end
    end
end
