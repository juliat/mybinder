class Teacher < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :school
  
  # Relationships
  # =================================================================================
  belongs_to :user

end
