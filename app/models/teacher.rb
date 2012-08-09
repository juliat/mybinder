class Teacher < ActiveRecord::Base
  attr_accessible :user_id, :first_name, :last_name, :school
  
  # Relationships
  # =================================================================================
  belongs_to :user
  has_many :course_classes
  has_many :courses, :through => :course_classes
  has_many :goals, :through => :courses
end
