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

# team hash contains information of the team members to always populate the db in the same manner

team_hash = { "Nancy"=>["Yost", 650],
 "Jarrod"=>["Pelosi", 650],
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

###########################################################################################
####################### CREATION OF THE PROJECTS ##########################################
###########################################################################################

puts "🌱 Creation of the projects starts 🌱"

# Here we will add 10 basic projects to the database

project_array = [
   # Project No. 1
  ["Bay View",
    "We represent Bay View Group LLC and The Spalena Company LLC in a claim brought against the Republic of Rwanda under the Rwanda – USA BIT in relation to the alleged expropriation of a mine.",
    "11-02-2017",
    "31-12-2021",
    1_500_000],

    # Project No. 2

    ["Singapore Matter",
      "We represent the shareholder of an Asian power plant in an ICC Arbitration in Singapore in relation to a claim against its gas supplier for breach of its gas supply contract.",
      "20-01-2016",
      "05-12-2020",
      2_000_000
    ],

    # Project No. 3

    ["Chapter 11 Proceedings",
      "We represent the committee of unsecured creditors of a major US retailer in its Chapter 11 restructuring.",
      "5-05-2019",
      "8-04-2020",
      800_000
    ]

    # Project No. 4

    [ "Seized Planes",
      "We represent a European investor in an arbitration arising from the seizure of planes in bankruptcy proceedings.",
      "20-02-2017",
      "20-08-2021",
      1_750_000
    ]

    # Project No. 5

    [ "Korean Energy Dispute",
      "We represent a Korean engineering company in an ad hoc construction arbitration relating to alleged delayed and deficient building works.",
      "25-08-2018",
      "29-03-2022",
      5_000_000
    ]






]
