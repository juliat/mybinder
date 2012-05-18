FactoryGirl.define do
	factory :activity do
		name "Physics Activity"
		rationale "This is a very important activity that addresses multiple learning goals."
		prior_knowledge "Students must know everything before doing this activity"
		association :topic
	end

	factory :author_org do
		name "Some organization that publishes standards"
	end
	
	factory :course do
		name "Some Course"
		description "The best class in the world"
	end
	
	#~ factory :document do
		#~ not testing b/c of complexity of testing with carrierwave; will come back to it
	#~ end
	
	#~ factory :equation do
		#~ ditto as document	
	#~ end
	
	factory :goal do
		statement "This is a highly important goal"
		number 1
		association :goal_type
		association :topic
	end
	
	factory :goal_type do
		name "Knowledge"
		description "A knowledge goal is one that has to do with something a student declaratively knows"
	end
	
	factory :key_concept do
		number 1
		statement "An important key concept"
		association :unit
	end
	
	factory :key_term do
		term "Physics Term"
		association :unit
	end
	
	factory :misconception do
		statement "This is a common student misconception"
		association :unit
		association :topic
	end
	
	factory :mod do
		number 1
		days 42
		association :unit
	end
	
	factory :online_resource do
		name "An Online Resource"
		description "This describes the online resource."
		url "http://www.superresource.com"
		association :user # who contributed it
		# association :resourceable
	end
	
	factory :problem_type do
		name "Conceptual"
	end
	
	factory :standard do
		statement "An academic standard."
		association :author_org
		association :unit # though temporary until mapped to goals
	end
	
	factory :standard_goal_mapping do
		association :standard
		association :goal
	end
	
	factory :teacher do
		first_name "John"
		last_name "Smith"
		school "Some School"
		belongs_to :user
	end
	
	factory :text_reference do
		book "Holr"
		location "p. 42"
		# association :textbookable
	end
	
	factory :threshold_problem do
		association :mod
		association :problem_type
		# http://bionuc-tech.blogspot.com/2010/08/factory-girl-polymorphic-associations.html
		after_build do |threshold_problem| 
			threshold_problem.text_reference = Factory.create(:text_reference, :textbookable => :threshold_problem) 
		end 
	end
	
	factory :topic do
		name "A Topic"
		number 3
		association :mod
	end
	
	factory :unit do
		association :course
		number 1
		name "Unit Name"
		start_date 5.months.ago.to_date
		end_date 4.months.ago.to_date
		days 42
		notes "Some notes about this unit."
	end
	
	factory :user do
		role "admin"
		email "admin@pghboe.edu"
		password "secret"
	end

end
