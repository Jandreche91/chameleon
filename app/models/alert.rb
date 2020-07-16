class Alert < ApplicationRecord
  belongs_to :project
  validates :description, presence: true

  def self.outstanding
    Alert.where(done: false)
  end

  def self.descriptions
    {
      budget_surpassed_85: "has surpassed 85 percent of the budget",
      budget_surpassed_50: "has surpassed 50 percent of the budget",
      progress_excess_time: "progress until end date is significantly higher than budget",
      progress_excess_budget: "budget spent is significantly higher than progress until end date"
    }
  end

  def self.generate
    Project.all.each do |project|
      generate_alerts_budget(project)
    end
  end

  def self.generate_alerts_budget(project)
    alerts = Alert.descriptions
    excess_budget = project.executed_budget_percentage - project.progress_date_percentage > 0.1
    excess_time = project.progress_date_percentage - project.executed_budget_percentage > 0.1
    surpass50 = project.executed_budget_percentage > 0.5
    surpass85 = project.executed_budget_percentage > 0.85
    check_for_50_surpass(project, surpass50, alerts)
    check_for_85_surpass(project, surpass85, alerts)
    check_for_excess_time(project, excess_time, alerts)
    check_for_excess_budget(project, excess_budget, alerts)
    check_for_milestones_to_end(project)
  end

  # These methods also check ehwehter the alert has already been produced

  def self.check_for_50_surpass(project, surpass50, alerts)
    conditions = surpass50 && project.alerts.where(description: alerts[:budget_surpassed_50]).empty?
    Alert.create(description: alerts[:budget_surpassed_50], project: project) if conditions
  end

  def self.check_for_85_surpass(project, surpass85, alerts)
    conditions = surpass85 && project.alerts.where(description: alerts[:budget_surpassed_85]).empty?
    Alert.create(description: alerts[:budget_surpassed_85], project: project) if conditions
  end

  def self.check_for_excess_time(project, excess_time, alerts)
    conditions = excess_time && project.alerts.where(description: alerts[:progress_excess_time]).empty?
    Alert.create(description: alerts[:progress_excess_time], project: project) if conditions
  end

  def self.check_for_excess_budget(project, excess_budget, alerts)
    conditions = excess_budget && project.alerts.where(description: alerts[:progress_excess_budget]).empty?
    Alert.create(description: alerts[:progress_excess_budget], project: project) if conditions
  end

  def self.check_for_milestones_to_end(project)
    project.milestones.each do |milestone|
      if milestone.end_date < Date.today + 60 && milestone.end_date > Date.today
        alert_description = "milestone #{milestone.description} will end in less than 60 days (#{milestone.end_date.strftime("%B %d, %Y")})"
        condition = project.alerts.where(description: alert_description).empty?
        Alert.create(description: alert_description, project: milestone.project) if condition
      end
    end
  end

  private_class_method :check_for_50_surpass, :check_for_85_surpass, :check_for_excess_budget, :check_for_excess_time
  private_class_method :generate_alerts_budget
end
