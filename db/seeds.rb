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

############## Creation of manager ########################################################
###########################################################################################

puts "🌱 Creation of manager starts 🌱"

manager = User.new( username: "john_smith",
                    first_name: "John",
                    last_name: "Smith",
                    hourly_rate: 750,
                    email: "john.smith@our_team.org",
                    password:"123456")
puts "🌱 Manager has User id #{manager.id} and was successfully saved! 🌱" if manager.save

###########################################################################################
####################### CREATION OF THE TEAM ##############################################
###########################################################################################

puts "🌱 Creation of the team starts 🌱"

team_hash = { "Nancy"=>["Yost", 650],
 "Jarrod"=>["Mante", 650],
 "Joan"=>["Mraz", 558],
 "Stepanie"=>["Murphy", 450],
 "Theodore"=>["Fisher", 440],
 "Pedro"=>["Ortiz", 330],
 "Chad"=>["Pfeffer", 330],
 "Grace"=>["Olson", 300],
 "Vincenzo"=>["Williams", 450],
 "Christina"=>["Tillman", 250],
 "Andreas"=>["Schumm", 200],
 "Antoine" => ["Konopelski", 150],
 "Abdul"=>["Saheem", 100],
 "Levi"=>["Schmeler", 100],
  "Rodney"=>["Weber", 280],
  "Frances"=>["Predovic", 350],
  "Julian"=>["McNelly", 120]
}

team_hash.each do |name, values|
  last_name = values[0]
  hourly_rate = values[1]
  associate = User.new( username: "#{name.downcase}_#{last_name.downcase}",
                    first_name: name,
                    last_name: last_name,
                    hourly_rate: hourly_rate,
                    email: "#{name.downcase}.#{last_name.downcase}@our_team.org",
                    password:"123456")
  puts "🌱 Profile for #{associate.first_name + " " + associate.last_name} created successfully 🌱" if associate.save
end
