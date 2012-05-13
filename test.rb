def createMatchDataHash(match_data)
	data_names = match_data.names
	data_values = match_data.captures
	data_hash = {}
	data_names.size.times do |i|
		data_hash[data_names[i]] = data_values[i].strip
	end 	
	return data_hash
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

#~ File.open("#{Rails.root}/public/data/curric/course_descr.txt") do |f|
Dir.foreach('./public/data/curric') do |file|
	puts file
	if file.match(/physics_unit_\d.txt$/)
		file = File.new("./public/data/curric/" + file, "r")
		# file = File.new("./public/data/curric/physics_unit_3.txt", "r")
		
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

		topicRegex = /^(\s{1,})?[A-Z][\w\s\?\(\)]{1,}$/
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
					mod["unit_id"] = unit["unit_num"]
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
					
				elsif current_mod != "" && moduleNotesRegex.match(line)
					modules[current_mod]["notes"] << line[2..line.size].strip
					
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
					problem["text"] = line[2..line.size].strip
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

		br = " ============================================================================= "

		puts unit
		puts br
		puts modules
		puts br
		puts standards
		puts br
		puts key_concepts
		puts br
		puts topics
		puts br
		puts goals
		puts br
		puts key_terms
		puts br
		puts misconceptions
		puts br
		puts threshold_problems
	end
end
