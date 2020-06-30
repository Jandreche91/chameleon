# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Alert.destroy_all
puts "All alerts destroyed ❗"
Assignment.destroy_all
puts "All assignments destroyed ❗"
Milestone.destroy_all
puts "All milestones destroyed ❗"
Project.destroy_all
puts "All projects destroyed ❗"
Task.destroy_all
puts "All tasks destroyed ❗"
User.destroy_all
puts "All users destroyed ❗"

# Creation of manager

puts "🌱 Creation of manager starts 🌱"

manager = User.new()
