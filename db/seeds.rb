# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def getUnitMetadata(unit, file)
	line = file.gets
	
	unit_metadata_regex = /Unit\W(?<unit_num>\d):\W(?<unit_name>[\w\s]{1,})#\s(?<unit_days>\d{1,2})\sdays\s#\s(?<start_date>\w{1,}\s\d{1,2})/
	match_data = line.match(unit_metadata_regex)

	data_names = match_data.names
	data_values = match_data.captures

	data_hash = {}

	data_names.size.times do |i|
		data_hash[data_names[i]] = data_values[i]
	end

	@unit.course_id = @course.id
	@unit.number = data_hash["unit_num"].to_i
	@unit.name = data_hash["unit_name"].strip
	@unit.start_date = Chronic.parse(data_hash["start_date"] + ", 2011").to_date
	@unit.days = data_hash["unit_days"].to_i

	@unit.save!
end


   
[Course, Unit].each(&:delete_all)

# Create course
@course = Course.new()
@course.name = "Grade 11 Physics"
descr_file = File.new("#{Rails.root}/public/data/curric/course_descr.txt", "r")
@course.description = descr_file.read

@course.save!


# Create unit

 
@unit = Unit.new 
file = File.new("#{Rails.root}/public/data/curric/physics_unit_1.txt", "r")

getUnitMetadata(@unit, file)



