class Project < ApplicationRecord
  # scope to get an array of the current ID's in the project

  scope :id, -> { all.select("id").map(&:id) }

  # validations and associations

  validates :name, :description, :estimated_start_date, :estimated_end_date, :estimated_cost, presence: true
  belongs_to :user
  has_many :assignments, dependent: :destroy
  has_many :alerts, dependent: :destroy
  has_many :milestones, dependent: :destroy
  has_many :tasks, through: :milestones
  has_many :users_as_billers, through: :assignments, source: :user


  # returns an array of hashes with the info of users billing
  # the time built and the value billed -- mirrors symbols of Taks model
  # returns data sorted by value
  def array_users_hours
    populate_data(users_as_billers)
  end

  def array_past_associates
    array_of_users = []
    User.all.each do |user|
      array_of_users << user if user.past_projects.include?(self)
    end
    populate_data(array_of_users)
  end

  # cost per hour on average

  def cost_per_hour
    if tasks.sum(:hours_spent).zero?
      0
    else
      tasks.sum(:value) / tasks.sum(:hours_spent)
    end
  end

  # auto calculate budget percentage -- returns integer between 0 and 100

  def executed_budget_percentage
    tasks.sum(:value).fdiv(estimated_cost)
  end

  # little method to return a formatted string instead of a plain integer
  def estimated_cost_formatted
    formatter(estimated_cost)
  end

  def executed_cost_formatted
    formatter(tasks.sum(:value))
  end

  # returns a hash with dates on the keys and cumulated value on the values

  def hash_cummulative_value
    results = {}
    value = 0
    tasks.sort_by(&:date).each do |task|
      value += task.value
      results[task.date.strftime('%Y-%m-%d %H:%M:%S')] = value
    end
    results
  end

  # returns a hash with dates on keys and cummulated values on the values for milestones

  def hash_milestone_estimated_cummulative_value
    results = { estimated_start_date.strftime('%Y-%m-%d %H:%M:%S') => 0 }
    value = 0
    milestones.sort_by(&:end_date).each do |milestone|
      value += milestone.progress_rate * estimated_cost / 100
      results[milestone.end_date.strftime('%Y-%m-%d %H:%M:%S')] = value
    end
    unless unassigned_progress_rate.zero?
      results[estimated_end_date.strftime('%Y-%m-%d %H:%M:%S')] = value += unassigned_progress_rate * estimated_cost / 100
    end
    results
  end

  # returns a hash with progress rates -- including unassinged if != 0
  # Returns an hash with the data to build a piechart. We use arrays to make sure an order is followed and we can pass
  # the exact same values to the CSS and to the JS

  def hash_milestone_progress_rates
    results = { colors: [], milestone_descriptions: [], milestone_proportions: [], milestone_objects: [] }
    colors =  Milestone.generate_colors
    milestones.sort_by(&:end_date).each_with_index do |milestone, index|
      results[:colors] << colors[index]
      results[:milestone_descriptions] << piechart_formatter(milestone)
      results[:milestone_proportions] << milestone.progress_rate * estimated_cost / 100
      results[:milestone_objects] << milestone
    end
  unless unassigned_progress_rate.zero?
    results[:colors] << '#778089'
    results[:milestone_descriptions] << "Unassigned - #{unassigned_progress_rate}%"
    results[:milestone_proportions] << unassigned_progress_rate * estimated_cost / 100
    results[:milestone_objects] << "Unassigned"
  end
    results
  end

  #old method commented out below

  # def hash_milestone_progress_rates
  #   results = {}
  #   milestones.sort_by(&:end_date).each do |milestone|
  #     results[piechart_formatter(milestone)] = milestone.progress_rate * estimated_cost / 100
  #   end
  #   results["Unassigned #{unassigned_progress_rate}%"] = unassigned_progress_rate * estimated_cost / 100 unless unassigned_progress_rate.zero?
  #   results
  # end

  def hours_spent_formatted
    formatter(tasks.sum(:hours_spent))
  end

  # returns array with outstanding alerts

  def outstanding_alerts
    alerts.where(done: false)
  end

  # auto calculate progress in time percentage -- returns integer between 0 and 100

  def progress_date_percentage
    remaining_days = (estimated_end_date - Date.today).to_i
    total_days = (estimated_end_date - estimated_start_date).to_i
    1 - remaining_days.fdiv(total_days)
  end

  # returns the unnasinged part of a project progress rate as an integer between 0 and 100

  def unassigned_progress_rate
    value = 100
    milestones.pluck(:progress_rate).each do |rate|
      value -= rate
    end
    return value
  end

  private

  def formatter(int)
    int.to_s.reverse.scan(/\d{3}|.+/).join(".").reverse
  end

  # a formatter for the keys in :hash_milestone_progress_rates

  def piechart_formatter(milestone)
    if milestone.end_date < Date.today
      ended_or_not = "Ended on #{milestone.end_date.strftime('%d %B %Y')}"
    else
      ended_or_not = "Ends on #{milestone.end_date.strftime("%d %B %Y")}"
    end
    "#{milestone.description} (#{milestone.progress_rate}%) -- #{ended_or_not}"
  end

  def populate_data(array_of_users)
    data = []
    array_of_users.each do |user|
      data << { user: user,
                hours_spent: tasks.where(user: user).sum(:hours_spent),
                value: tasks.where(user: user).sum(:value) }
    end
    return data.sort_by { |user_hash| user_hash[:value] }.reverse
  end
end
