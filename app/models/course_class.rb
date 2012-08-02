class CourseClass < ActiveRecord::Base
  attr_accessible :course_id, :name, :teacher_id, :start_date, :end_date
  
  # Relationships
  # =================================================================================
  belongs_to :course
  belongs_to :teacher
  
end
