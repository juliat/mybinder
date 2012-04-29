class Misconception < ActiveRecord::Base
  attr_accessible :statement, :topic_id
  
  # Relationships
  belongs_to :topic
end
