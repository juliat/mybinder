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

end
