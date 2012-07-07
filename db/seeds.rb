# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


def createMatchDataHash(match_data)
	data_names = match_data.names
	data_values = match_data.captures
	data_hash = {}
	data_names.size.times do |i|
		data_hash[data_names[i]] = data_values[i].strip
	end 	
	return data_hash
end

def parseFile(file, modelType)
	if modelType == "Activity"
		file_abbreviation = "A"
	elsif modelType == "Equation"
		file_abbreviation = "Eq"
	end

	puts "Parsing file #{file}"
	fileRegex = /U(?<unit_num>\d)_M(?<mod_num>\d)[\w_]{0,}(?<file_type>((\.gif)|(\.txt)|(\.doc)|(\.docx)|(\.ppt)|(\.pdf)))/

	puts file

	matchData = file.match(fileRegex)
	if matchData.nil?
		puts "NO MATCH: #{file}"
	else
		puts "MATCH: #{file}"
		fileInfo = createMatchDataHash(matchData)
	end
	
	return fileInfo
end

# takes a module and returns an array of equation objects for it
# (equation objects have mod_id., number, img file and latex)
def getUnitEquations(unit, modules)
	directory = "./public/data/physics_curriculum/unit_#{unit["unit_num"]}/equations/"
	
	unitEquations = Dir.entries(directory).select{|entry| entry.length > 2}
	puts unitEquations
	
	equationsHash = {}
	unitEquations.each do |e|
		eFileName = e # save filename
		
		# get hash of data about file 
		e = parseFile(e, "Equation")
		# add the full filename to that hash, minus the extension
		e['file'] = eFileName
		
		puts e
		
		# now use eFileName variable to store file name with no extension
		eFileName = eFileName[0, eFileName.length - 4]
		
		# if the equationObjects array doesn't already contain an equation  with the same filename (no extension)
		unless equationsHash.keys.include?(eFileName) 
			# then create a new equation object that's got that as the filename 
			equation = Equation.new()
			equation.mod_id = e['mod_num'] # this is incorrect, just storing mod num here
			# so we can use it to find the module that we want in saveData and use its id
			equation.number = e['eq_num']
		else
			equation = equationsHash[eFileName]
		end
		
		# depending on the file extension, either save the image_file or latex	
		if e['file_type'] == ".gif" 
			equation.image_file = File.new(directory + e['file'])
		elsif e['file_type'] == ".txt"
			equation.latex = File.new(directory + e['file'], 'r').gets()
		end
		
		# then save the updated equation to the equationsHash
		equationsHash[eFileName] = equation	
	end
	# map the equationsHash into an array of equation objects
	equations = equationsHash.map{|fileName, equationObject| equationObject}
	
	return equations
end

# takes a blurb of text about an activity
# returns a hash including the activity name and rationale
def parseActivityName(txt)
	nameRegex = /Activity Name: (?<name>[\w \(\)-]{1,})[\s]/
	match_data = txt.match(nameRegex)
	if match_data.nil?
		puts 'NO MATCH'
		return
	else
		activityData = createMatchDataHash(match_data)
	end
	return activityData
end

def getUnitActivities(unit)
	directory = "./public/data/physics_curriculum/unit_#{unit["unit_num"]}/activities/"

	unitActivities = Dir.entries(directory).select{|entry| entry.length > 2}
	
	puts "Unit Activities:"
	puts unitActivities
	
	activitiesHash = {}
	unitActivities.each do |a|
		aFileName = a # save filename
		
		# get hash of data about file 
		a = parseFile(a, "Activity")
		# add the full filename to that hash, minus the extension
		a['file'] = aFileName
		
		puts "File: "
		puts a
		
		# now use eFileName variable to store file name with no extension
		unless a['file_type'] == ".docx"
			fileExtensionLength = 4
		else
			fileExtensionLength = 5
		end

		# in this case, the filename is the first part : U#_M#_A#
		aFileName = aFileName[0, 8]
		puts aFileName
		
		# if the equationObjects array doesn't already contain an activity with the same filename (no extension)
		unless activitiesHash.keys.include?(aFileName) 
			# then create a new equation object that's got that as the filename 
			activity = Activity.new()
			# activity.topic_id
			activity.number = a['a_num']
		else
			activity = activitiesHash[aFileName]
		end
		
		# if the file's not a text file, then it's an associated doc (for a detailed activity (?))
		if a['file_type'] == ".txt"
			# fetch and read file text
			file = File.new(directory + a['file'], 'r')
			firstLine = file.gets()
			aData = parseActivityName(firstLine)
			# add data from file to activity object
			if aData['name'].nil?
				puts "UH OH"
				return
			end
			activity.name = aData['name']

			rationale = ""
			# lines that aren't first line are rationale
			file.each_line do |line|
				unless line == firstLine
					rationale << line
				end
			end

			#add rationale to activity object
			activity.rationale = rationale

			puts "Activity:"
			puts activity.name
			puts activity.rationale
	

			# then save the updated activity to the activitiesHash
			activitiesHash[aFileName] = activity
		end
	end
	# map the activitiesHash into an array of activity objects
	activities = activitiesHash.map{|fileName, activityObject| activityObject}
	
	return activities
end


def setDateYear(datestr, date)
	if date.month >= 9
		return datestr + " 2011"
	else
		return datestr + " 2012"
	end
end

def saveData(data_hash)
	
	# save unit
	@unit = Unit.new
	@unit.course_id = @course.id
	@unit.number = data_hash["unit"]["unit_num"].to_i
	@unit.name = data_hash["unit"]["unit_name"].strip
	start_date = setDateYear(data_hash["unit"]["start_date"], Chronic.parse(data_hash["unit"]["start_date"]))
	end_date = setDateYear(data_hash["unit"]["end_date"], Chronic.parse(data_hash["unit"]["end_date"]))
	@unit.start_date = Chronic.parse(start_date).to_date
	@unit.end_date = Chronic.parse(end_date).to_date
	@unit.days = data_hash["unit"]["unit_days"].to_i
	@unit.notes = data_hash["unit"]["notes"]
	@unit.save!
	
	# save standards
	data_hash["standards"].each do |standard|
		@standard = Standard.new()
		@standard.unit_id = @unit.id
		@standard.author_org_id = @standards_author.id
		@standard.author_org_code = standard["code"]
		@standard.statement = standard["statement"]
		@standard.save!
	end
	
	# modules
	modules = data_hash["modules"]
	modules.each do |mod_num, mod|
		@mod = Mod.new()
		@mod.days = mod["num_days"]
		@mod.number = mod["module_num"].to_i
		@mod.unit_id = @unit.id
		@mod.save!
		mod["notes"].each do |note|
			@textRef = TextReference.new()
			@textRef.book = note["textbook"]
			@textRef.location = note["location"]
			@textRef.textbookable_id = @mod.id
			@textRef.textbookable_type = "Mod"
			@textRef.save!
		end
		# equations
		equations = data_hash["equations"]
		# equations are already objects: only have to save them
		equations.each do |eq|
			if eq.mod_id.to_i == mod_num.to_i
				eq.mod_id = @mod.id
				eq.save!
			end
		end
		
		@mod.save!
	end

	# activities
	activities = data_hash["activities"]
	activities.each do |a|
		puts a.name
		a.save!
	end
	
	# topics
	topics = data_hash["topics"]
	count = 1
	topics.each do |topic|
		@topic = Topic.new()
		module_num = topic["mod"]
		@mod = Mod.where("unit_id = ?", @unit.id).where("number = ?", module_num).first
		@topic.mod_id = @mod.id
		@topic.number = count
		@topic.name = topic["name"]
		@topic.save!
		count = count + 1
	end
	
	# goals
	goals = data_hash["goals"]
	goals.each do |goal|
		@goal = Goal.new()
		@goal.topic_id = Topic.find_by_name(goal["topic"]).id
		@goal.number = goal["number"]
		@goal.statement = goal["statement"]
		@goal.save!
	end
	
	# key_concepts
	key_concepts = data_hash["key_concepts"]
	key_concepts.each do |concept|
		@concept = KeyConcept.new()
		@concept.unit_id = @unit.id
		@concept.number = concept["number"].to_i
		@concept.statement = concept["statement"]
		@concept.save!
	end
	
	# key terms
	key_terms = data_hash["key_terms"]
	key_terms.each do |term|
		@term = KeyTerm.new()
		@term.unit_id = @unit.id
		@term.term = term["term"]
		# differentiated for psp -- field?
		@term.save!
	end
	
	# misconceptions
	misconceptions = data_hash["misconceptions"]
	misconceptions.each do |miscon|
		@miscon = Misconception.new()
		@miscon.statement = miscon.gsub(/\?/, "'").capitalize
		@miscon.unit_id = @unit.id
		@miscon.save!
	end	
	
	# threshold problems
	threshold_problems = data_hash["threshold_problems"]
	threshold_problems.each do |problem|
		@prob = ThresholdProblem.new()
		
		problem_type_id = ProblemType.find_by_name(problem["type"]).id
		@prob.problem_type_id = problem_type_id
		
		# set module relationship
		module_num = problem["module"]
		@prob_mod = Mod.where("unit_id = ?", @unit.id).where("number = ?", module_num).first	
		
		@prob.mod_id = @prob_mod.id
		
		@prob.save!
		
		@textR = TextReference.new()
		@textR.book = problem["text"]["textbook"]
		@textR.location = problem["text"]["location"]
		@textR.textbookable_id = @prob.id
		@textR.textbookable_type = "ThresholdProblem"
		@textR.save!
	end	
end
   

def parseUnitData(line)
	unit_metadata_regex = /Unit\W(?<unit_num>\d):\W(?<unit_name>[\w\s\(\)-]{1,})\?\s(?<unit_days>\d{1,2})\sdays\s\?\s(?<start_date>\w{1,}\s\d{1,2}) through (?<end_date>\w{1,}\s\d{1,2})/
	match_data = line.match(unit_metadata_regex)
	unit = createMatchDataHash(match_data)
	unit["unit_name"] = unit["unit_name"].split.each{|word| word.capitalize!}.join(" ")
	return unit
end

def parseModuleData(line)
	moduleRegex = /\* Module (?<module_num>\d) \((?<num_days>\d{1,2}) days\)/
	match_data = line.match(moduleRegex)
	return createMatchDataHash(match_data)
end

def parseStandard(line)
	standardRegex = /\* (?<code>S\d\d\.\w\.(\d\.?){3}) (?<statement>[\w\s\(\)\.\,]{1,})/
	match_data = line.match(standardRegex)
	return createMatchDataHash(match_data)
end

def parseTextbookRef(line)
	txtRefRegex = /(?<textbook>(Holt|Hewitt)) (?<location>.{1,})/
	match_data = line.match(txtRefRegex)
	return createMatchDataHash(match_data)
end

# Done defining; now running things
# =====================================================================================================================


[User, Course, Unit, Mod, Topic, Goal, Misconception, ProblemType, ThresholdProblem, TextReference, Equation].each(&:delete_all)

# create admin
@user = User.new()
@user.email = "julialt@gmail.com"
@user.password = "secret"
@user.password_confirmation = "secret"
@user.role = "admin"
@user.save!

# Create course
@course = Course.new()
@course.name = "Grade 11 Physics"
descr_file = File.new("#{Rails.root}/public/data/physics_curriculum/txt/course_descr.txt", "r")
@course.description = descr_file.read
@course.save!

# Create author org
@standards_author = AuthorOrg.new()
@standards_author.name = "Pennsylvania Assessment Anchor Content Standards"
@standards_author.save!

# problem types
prob_types = ["Conceptual", "Computational"]
for type in prob_types
	@type = ProblemType.new()
	@type.name = type
	@type.save!
end

Dir.foreach('./public/data/physics_curriculum/txt/') do |file|
	puts file
	if file.match(/physics_unit_\d.txt$/)
		file = File.new("./public/data/physics_curriculum/txt/" + file, "r")
		# file = File.new("./public/data/physics_curriculum/txt/physics_unit_3.txt", "r")
		
		inUnitMeta = true # always true initially b/c always the first line

		moduleRegex = /\* Module (?<module_num>\d) \((?<num_days>\d{1,2}) days\)/
		inModuleName = false

		moduleNotesRegex = /o (Holt|Hewitt) pp \d{1,3}-\d{1,3}/
		inModuleNotes =false

		unitNotesRegex = /Note:/
		inUnitNotes = false

		eligibleContentRegex = /^Eligible Content:(\s)?$/
		inEligibleContent = false
		standardRegex = /\* (?<code>S\d\d\.\w\.(\d\.?){3}) (?<statement>[\w\s\(\)\.\,]{1,})/

		keyConceptsRegex = /^Key Concepts:(\s){1,}?$/
		inKeyConcepts = false

		goalsRegex = /Content Expectations and Performance Expectations/
		inGoals = false

		moduleTitleRegex = /^(\s)?Module (?<module_num>\d)$/
		current_mod = ""

		topicRegex = /^(\s{1,})?[A-Z][\w\s\?\(\):]{1,}$/
		inTopic = false

		olRegex = /^(?<number>\d{1,2}).(\s){1,}(?<statement>[\w\s,\(\)\.\-\/#;\?\+]{1,})$/

		pspRegex = /Differentiation for PSP/
		inPSPGoals = false

		keyTermsRegex = /Key Terms/
		inKeyTerms = false
		inPSPterms = false

		keyTermRegex = /^\* (?<term>[\w\s]{1,})$/

		misconceptionRegex = /^Misconceptions:(\s)?$/
		inMisconceptions = false

		summaryRegex = /Summary of Unit/
		inSummary = false

		thresholdRegex = /Threshold problems:/
		inThresholdProblems = false
		inPSPproblems = false
		problem_type = ""

		thresholdProblemRegex =/\* (Holt|Hewitt) (pp|p\.)[#\d\s,-]{1,}(\w)?/

		thresholdModuleRegex = /^Module (?<mod_num>\d)(\s)?$/

		whitespaceRegex = /^[\s]{1,}$/

		unit = {}
		# will have number, name, start date, end date, and days

		modules = {}
		# each mod will have number and number of days, also an array of notes
		current_mod = ""

		thresh_mod_num = ""

		standards = []
		key_concepts = []
		key_terms = []
		topics = []
		current_topic = ""
		goals = []
		misconceptions = []
		threshold_problems = []

		file.each_line do |line|
			unless whitespaceRegex.match(line)
				if inUnitMeta
					# parse unit metadata and save to unit hash
					unit = parseUnitData(line)
					unit["notes"] = []
					inUnitMeta = false
					
				elsif moduleRegex.match(line)
					inModuleName = true
					mod = parseModuleData(line)
					mod["unit"] = unit["unit_name"]
					mod["notes"] = []
					modules[mod["module_num"]] = mod
					current_mod = mod["module_num"]
					
				elsif inModuleName && unitNotesRegex.match(line)
					current_mod = ""
					inModuleName = false
					inUnitNotes = true
					
				elsif eligibleContentRegex.match(line)
					inUnitNotes = false
					inEligibleContent = true
					
				elsif keyConceptsRegex.match(line)
					inEligibleContent = false
					inKeyConcepts = true
				
				elsif goalsRegex.match(line)
					inKeyConcepts = false
					inGoals = true
					
				elsif keyTermsRegex.match(line)
					inKeyTerms = true
					inGoals = false
					inTopic = false
				
				elsif misconceptionRegex.match(line)
					inKeyTerms = false
					inMisconceptions = true
				
				elsif summaryRegex.match(line)
					inMisconceptions = false
					inSummary = true
				
				elsif thresholdRegex.match(line)
					inSummary = false
					inThresholdProblems = true
				
				elsif moduleTitleRegex.match(line)
					current_mod = moduleTitleRegex.match(line)["module_num"]
				
				elsif inGoals && topicRegex.match(line) && thresholdModuleRegex.match(line).nil?
					if pspRegex.match(line).nil?
						inPSPGoals = false
						inTopic = true
						topic = {}
						topic["name"] = line.strip
						topic["mod"] = current_mod
						topics << topic
						current_topic = topic["name"]
					else
						inPSPGoals = true
					end
					
				# in Module Notes	
				elsif current_mod != "" && moduleNotesRegex.match(line)
					modules[current_mod]["notes"] << parseTextbookRef(line)
					
				elsif inUnitNotes
					unit["notes"] << line[2..line.size].strip
					
				elsif inEligibleContent && standardRegex.match(line)
					inUnitNotes = false
					standards << parseStandard(line)
					
				elsif inKeyConcepts && olRegex.match(line)
					concept = createMatchDataHash(olRegex.match(line))
					key_concepts << concept
					
				elsif inTopic && olRegex.match(line)
					goal = createMatchDataHash(olRegex.match(line))
					goal["topic"] = current_topic
					if inPSPGoals
						goal["PSP"] = true
					else
						goal["PSP"] = false
					end
					goals << goal
				
				elsif inKeyTerms && pspRegex.match(line)
					inPSPterms = true
				
				elsif inKeyTerms && keyTermRegex.match(line)
					term = createMatchDataHash(keyTermRegex.match(line))
					if inPSPterms
						term["PSP"] = true
					else
						term["PSP"] = false
					end
					key_terms << term
				
				elsif inMisconceptions
					misconceptions << line[2..line.size].strip
				
				elsif thresholdModuleRegex.match(line)
					current_mod = createMatchDataHash(thresholdModuleRegex.match(line))["mod_num"]
				
				elsif inThresholdProblems && topicRegex.match(line)
					if pspRegex.match(line).nil?
						problem_type = line.strip
						inPSPproblems = false
						if problem_type.include?("problems")
							problem_type = line.split(" ")[0]
						end
					else
						inPSPproblems = true
					end
				
				elsif inThresholdProblems && thresholdProblemRegex.match(line)
					problem = {}
					problemLine = line[2..line.size].strip
					problem["text"] = parseTextbookRef(problemLine)
					problem["type"] = problem_type
					problem["module"] = current_mod	
					if inPSPproblems
						problem["PSP"] = true
					else
						problem["PSP"] = false
					end
					threshold_problems << problem
				end
			end
		end
		
		# now get all the equations for the unit
		equations  = getUnitEquations(unit, modules)
		activities = getUnitActivities(unit)

		data_hash = { "unit" => unit,
					  "modules" => modules,
					  "standards" => standards,
					  "key_concepts" => key_concepts,
					  "topics" => topics,
					  "goals" => goals,
					  "key_terms" => key_terms,
					  "misconceptions" => misconceptions,
					  "threshold_problems" => threshold_problems,
					  "equations" => equations,
					  "activities" => activities
					}
		saveData(data_hash)
	end
end



