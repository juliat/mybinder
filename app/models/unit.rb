class Unit < ActiveRecord::Base
  attr_accessible :course_id, :name, :start_date, :weeks
  
  # Relationships
  belongs_to :course
end
