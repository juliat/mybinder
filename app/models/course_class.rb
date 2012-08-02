class CourseClass < ActiveRecord::Base
  attr_accessible :course_id, :name, :teacher_id
end
