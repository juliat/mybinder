line = "Unit 1: one dimensional motion # 22 days # Sept 1 through Oct 4
* Module 1 (10 days)
o Holt pp 1-47
o Hewitt pp 1-50
o Note: The order of topics in Unit 1 aligns with Holt.  Hewitt begins forces on page 12.  Forces will be covered in Unit 3.
* Module 2 (12 days)
o Holt pp 48-79
o Hewitt pp 51-67

Note:
* Units 1 and 2 are to be finished by the close of the first quarter
* First quarter closes on Nov 10, 2011"

unit_metadata_regex = /Note:*(?<notes>[\w\s]{1,})/
match_data = line.match(unit_metadata_regex)
puts "match_data " 
puts match_data.captures

