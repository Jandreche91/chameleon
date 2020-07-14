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
    if excess_budget && project.alerts.where(description: alerts[:progress_excess_budget]).empty?
      Alert.create(description: alerts[:progress_excess_budget], project: project)
    end
    if excess_time && project.alerts.where(description: alerts[:progress_excess_time]).empty?
      Alert.create(description: alerts[:progress_excess_time], project: project)
    end
    if surpass50 && project.alerts.where(description: alerts[:budget_surpassed_50]).empty?
      Alert.create(description: alerts[:budget_surpassed_50], project: project)
    end
    if surpass85 && project.alerts.where(description: alerts[:budget_surpassed_85]).empty?
      Alert.create(description: alerts[:budget_surpassed_85], project: project)
    end
  end
end
