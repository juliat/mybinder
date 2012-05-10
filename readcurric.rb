# standard structure for unit doc
#-----------------------------------------------------------------------------------
# Unit [num]: [title]   [num_days] days   [start date] through [end date]
# * Module [num] ([num_days] days)
# o [textbook pages]
# o [textbook pages]
# o [notes]
# * Module [num] ([num_days] days)
# o [textbook pages]
# o [textbook pages]
# o [notes]
# 
# Note: 
# * [note, probably about pacing]
# * [note, probably about pacing]
# 
# Eligible Content:
# * [coded std #]  [statement]  # example below
# * S11.C.3.1.3  Describe the motion of an object using variables (i.e., acceleration, velocity, displacement).
# * ...
#
# Key Concepts:
# 1. [statement]
# 2. ...
# 3. ...
# 4. ...
# a.
#
# Content Expectations and Performance Expectations (in italics) by module/topic:

class Unit
	attr_accessor :name, :number, :days, :notes
	def initialize
	end
end

class Module
	attr_accessor :unit_id, :name, :number, :days
end

class Topic
	attr_accessor :mod_id, :name
end

class Goal
	attr_accessor :topic_id, :number, :statement
end

class Standard
	attr_accessor :num, :statement
end



	
	


