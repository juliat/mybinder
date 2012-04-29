class Course < ActiveRecord::Base
  attr_accessible :description, :name
  
  # Relationships
  has_many :units
end
