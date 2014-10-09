# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Datas are feeded for development On 04/13/2014 for below tables

Service.create([{:service_type => 'Skill Sharing'}])

SubCategory.create([
{ :sub_category_type => 'All' },
{ :sub_category_type => 'Dance & Fitness' }, 
{ :sub_category_type => 'Music' }, 
{ :sub_category_type => 'Cooking' }, 
{ :sub_category_type => 'Teaching & Education' }, 
{ :sub_category_type => 'Professional Skill' }, 
{ :sub_category_type => 'Sports' }, 
{ :sub_category_type => 'Art and Crafts'}])
