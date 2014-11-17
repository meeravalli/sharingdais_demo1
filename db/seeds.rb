# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Datas are feeded for development On 04/13/2014 for below tables

Category.create([
{ :category_name => 'Academic Books' }, 
{ :category_name => 'Biography & Autobiography' }, 
{ :category_name => 'Comics' }, 
{ :category_name => 'Crime, Thriller & Mystery' }, 
{ :category_name => 'Fiction' }, 
{ :category_name => 'Health & Fitness' }, 
{ :category_name => 'Home & Lifestyle' }, 
{ :category_name => 'Literature' }, 
{ :category_name => 'Motivational' }, 
{ :category_name => 'Non-Fiction' },
{ :category_name => 'Romance' }, 
{ :category_name => 'Others'}])
puts "Done Category seed DATA"
