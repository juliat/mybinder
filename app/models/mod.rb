class Mod < ActiveRecord::Base
  attr_accessible :days, :unit_id
  
  # has_many threshold_problems
  # has_many threshold_equations
  belongs_to :unit
  has_many :topics
  
end
