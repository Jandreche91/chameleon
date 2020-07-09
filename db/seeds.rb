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

manager = User.new( username: "patricia_smith",
                    first_name: "John",
                    last_name: "Smith",
                    hourly_rate: 750,
                    email: "john.smith@ourteam.org",
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
 "Stephanie"=>["Murphy", 450],
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
                    email: "#{name.downcase}.#{last_name.downcase}@ourteam.org",
                    password:"123456")
  puts "🌱 Profile for #{associate.first_name + " " + associate.last_name} created successfully 🌱" if associate.save
end



puts "🌱 Creation of the projects starts 🌱"

###########################################################################################
#################### PROJECT ARRAY ########################################################
###########################################################################################

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
      "8-08-2020",
      800_000
    ],

    # Project No. 4

    [ "Seized Planes",
      "We represent a European investor in an arbitration arising from the seizure of planes in bankruptcy proceedings.",
      "20-02-2017",
      "20-08-2021",
      1_750_000
    ],

    # Project No. 5

    [ "Korean Energy Dispute",
      "We represent a Korean engineering company in a dispute relating to alleged delayed and deficient building works.",
      "25-08-2018",
      "29-03-2022",
      5_000_000
    ],

    # Project No. 6

    [ "Egg Dispute",
      "We represent a French company in dispute relating to delayed delivery of eggs.",
      "13-05-2019",
      "29-11-2021",
      700_000
    ],

    #Project No. 7

    [ "Highway Dispute",
      "We represent a Spanish construction company in a dispute against a South American State arising from delays in the construction of a highway.",
      "11-01-2016",
      "20-09-2020",
      2_800_000
    ],

    # Project No. 8

    ["Glass Dispute",
      "We represent a Russian company in a dispute against a French Company arising from alleged defects in the production of glass products.",
      "19-05-2019",
      "20-10-2020",
      1_300_000
    ],


    # Project No. 9

    [ "Ice Cream Dispute",
      "We represent an American Ice Cream manufacturer in a dispute for delays in the delivery of raw material shipments.",
      "20-08-2016",
      "20-12-2021",
      1_000_000
    ],

    # Project No. 10

    ["Oil Companies Dispute",
      "We represente an oil company in a dispute against another oil company concerning the payment of gasoil deliveries.",
      "20-11-2019",
      "20-12-2022",
      500_000
    ]
  ]

###########################################################################################
####################### AUTOMATIC CREATOR OF MILESTONES ###################################
###########################################################################################

# generate a random distribution of 100%
# return an array with the four distribution equally 100 as a sum
def create_distribution
  results = []
  distribution = 100
  first_distribution = rand(10..28)
  results << first_distribution
  distribution -= first_distribution
  second_distribution = rand(30..40)
  results << second_distribution
  distribution -= second_distribution
  third_distribution = rand(25..30)
  results << third_distribution
  distribution -= third_distribution
  results << distribution
  results
end

def milestone_creator(new_project)
  #array with a random distribution as per the method above
    distribution = create_distribution
    descriptions = ["Initial phase and revision of documents", "Written phase", "Oral phase", "Analysis of decision and strategy of enforcement / challenge"]
    #create four milestones according to the four elements of the proportion
    distribution.each_with_index do | proportion, index |

      #calculate the number of days of the project

      total_project_days = (new_project.estimated_end_date - new_project.estimated_start_date).to_i

      new_milestone = Milestone.new
      new_milestone.progress_rate = proportion
      new_milestone.description = descriptions[index]
      #establish the end date of the milestone as initial date of project plus relative proportion
      relative_proportion = distribution[0..index].sum
      new_milestone.end_date = new_project.estimated_start_date + (total_project_days * relative_proportion / 100)
      #establish a cutoff date to randomise whether the milestone is over as at today
      cutoff_date = Date.today + rand(60) - rand(60)
      new_milestone.done = true if new_milestone.end_date <= cutoff_date
      new_milestone.project = new_project
      puts "Milestone id #{new_milestone.id} for project #{new_project.name} saved successfully 🎟" if new_milestone.save
    end

end

###########################################################################################
####################### CREATION OF THE PROJECTS WITH THE MILESTONES#######################
###########################################################################################

# creation of the models , all are owned by the manager user

  project_array.each do |project|

    new_project = Project.new( name: project[0],
      description: project[1],
      estimated_start_date: project[2],
      estimated_end_date: project[3],
      estimated_cost: project[4])
    new_project.user = manager
    puts "#{new_project.name} sucessfully created! 🌱" if new_project.save
    milestone_creator(new_project)
  end


###########################################################################################
####################### CREATION OF ASSIGNMENTS TO USERS ##################################
###########################################################################################


# as array and not as activerecord relation

senior_associates =  [] + User.where("hourly_rate > 400")
  #delete from this array the manager

senior_associates.delete(manager)

puts "🌱 assigning senior associates 🌱"

Project.all.each_with_index do |project, index|

  assignment = Assignment.new
  assignment.project = project

      if senior_associates[index].nil?
        assignment.user = senior_associates.sample
      else
        assignment.user  = senior_associates[index]
      end

  puts "#{assignment.user.username} (#{assignment.user.id}) has been assigned to project #{project.name} (#{project.id}) 👾" if assignment.save

  end


# assigning junior associates

puts "🌱 assigning junior associates 🌱"

junior_associates = [] + User.where("hourly_rate <= 400")


junior_associates.each do |associate|
  projects = Project.all.sample(4)
  projects.each do |project|
    assignment = Assignment.new
    assignment.project = project
    assignment.user = associate
    puts "#{assignment.user.username} (#{assignment.user.id}) has been assigned to project #{project.name} (#{project.id}) 👾" if assignment.save
  end
end

###########################################################################################
####################### CREATION OF TASKS in MILESTONE ####################################
###########################################################################################


def give_description
  descriptions = ["Drafting document to send to client",
                  "Reviewing document of the case",
                  "Making important calls with the other party",
                  "Making important calls with the client",
                  "Internal meetings and drafting documents",
                  "Doing legal research",
                  "Doing fact checking",
                  "Doing fact finding"
                ]
  descriptions.sample
end


# method to add tasks to a finished milestone


def add_tasks_to_milestone(milestone)

  # determination of random compliance with budget between 0.95 and 1.2 in of assigmnent
  budget_compliance = rand(0.95..1.1)
  project = milestone.project
  budget_of_milestone = project.estimated_cost * milestone.progress_rate / 100
  actual_cost_of_milestone = budget_of_milestone * budget_compliance
       until actual_cost_of_milestone < 1_000
        task = Task.new
        task.user = project.users_as_billers.sample
        task.hours_spent = rand(1..8)
        task.description = give_description
        task.milestone = milestone
        early_date = milestone.end_date - 200 < project.estimated_start_date ? project.estimated_start_date : milestone.end_date - rand(100-200)
        task.date = rand(early_date..milestone.end_date)
        task.value = task.hours_spent * task.user.hourly_rate
            if task.save
              puts "New task registered for milestone #{milestone.id} of project #{project.name} ⏰"
              actual_cost_of_milestone -= task.value
              puts "Cost of milestone is #{actual_cost_of_milestone}"
            end
        end
end

Milestone.all.each do |milestone|

  if milestone.done == true
    add_tasks_to_milestone(milestone)
  else
    puts "nothing for the moment 😆"
  end

end

# add task to an unfinished milestone

# method to add tasks to unfinished milestones

def add_task_to_unfinished_milestone(milestone)
  budget_weight = rand(0.25..0.75)
  project = milestone.project
  budget_of_milestone = project.estimated_cost * milestone.progress_rate / 100 * budget_weight
  associates = project.users_as_billers

  until budget_of_milestone < 1_000
    task = Task.new
        task.user = project.users_as_billers.sample
        task.hours_spent = rand(1..8)
        task.description = give_description
        task.milestone = milestone
        before = Date.today - 200
        task.date = rand(before..Date.today)
        task.value = task.hours_spent * task.user.hourly_rate
            if task.save
              puts "New task registered for milestone #{milestone.id} of project #{project.name} ⏰"
              budget_of_milestone -= task.value
              puts "Cost of milestone is #{budget_of_milestone}"
            end

  end



end


Project.all.each do |project|

  unfinished_milestones = project.milestones.select {|milestone| milestone.done == false }

  add_task_to_unfinished_milestone(unfinished_milestones[0]) unless unfinished_milestones.empty?

end


###########################################################################################
####################### Adding a Little alert in the end###################################
###########################################################################################

project = Project.where(name:"Singapore Matter")[0]
alert = Alert.new
alert.description = "has surpassed 85 percent of the budget"
alert.project = project

puts "alert created related to #{alert.project.name} was created" if alert.save



# The end

puts "🎊🎊🎊🎊 Seed has finalised successfully! 🎊🎊🎊🎊"
