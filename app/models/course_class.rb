class CourseClass < ActiveRecord::Base
  
  # Callbacks
  after_create :create_goal_progresses_for_class
  
  attr_accessible :course_id, :name, :teacher_id, :start_date, :end_date
  
  # Relationships
  # =================================================================================
  belongs_to :course
  belongs_to :teacher
  
  # Scopes
  # =================================================================================
  scope :for_teacher, lambda {|teacher_id| where("teacher_id = ?", teacher_id)}
  
  # Callbacks
  # =================================================================================
  # When a course is created, create goal_progresses for all the goals for that course
  def create_goal_progresses_for_class
	course_goals = self.course.goals
	for goal in course_goals
		@goalProgress = GoalProgress.new
		@goalProgress.goal = goal
		@goalProgress.course_class = self
		@goalProgress.save!
	end
  end
  
end
