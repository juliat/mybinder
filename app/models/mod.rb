class Mod < ActiveRecord::Base

    attr_accessible :number, :days, :unit_id, :threshold_problems_attributes, :text_references_attributes, :equations_attributes
    
    # Validations
    # =================================================================================
    validates_numericality_of :number
    validates_numericality_of :days
    
  
    # Relationships
    # =================================================================================
    has_many :equations
    has_many :threshold_problems
    has_many :text_references, :as => :textbookable, :dependent => :destroy
   
    belongs_to :unit
    has_many :topics
    has_many :goals, :through =>  :topics
    has_many :activities, :through => :topics
    # has_many :misconceptions
    
    accepts_nested_attributes_for :text_references, :allow_destroy => true
    accepts_nested_attributes_for :threshold_problems, :allow_destroy => true
    accepts_nested_attributes_for :equations, :allow_destroy => true
    
    # Scopes
    # =================================================================================
    scope :for_unit, lambda {|unit_id| where("unit_id = ?", unit_id) }
    scope :in_order, order('number')
    
    
    # Methods
    # =================================================================================    
    
    # returns a hash mapping problem type names to lists of problems of that type
    def sorted_threshold_problems
        # if there are no threshold problems, return nil
        unless self.threshold_problems.empty?
            return nil
        end
        sorted_problems = {}
        problem_types = ProblemType.all.map{|type| type.name}
        problem_count = 0
        # for each type
        problem_types.each do |type|
            # get all the problems of that type and put the problems into an array
            types_problems = []
            problems_for_type = self.threshold_problems.for_type(type)
            problems_for_type.each do |prob|
                types_problems << prob.problem
            end
            # then make a key in the problems hash that maps to the array or problems
            sorted_problems[type] = types_problems
        end   
        return sorted_problems
    end
    
    def name
        "Module #{number}"
    end
end
