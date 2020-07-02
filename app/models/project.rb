class Project < ApplicationRecord
  validates :name, :description, :estimated_start_date, :estimated_end_date, :estimated_cost, presence: true
  belongs_to :user
  has_many :assignments, dependent: :destroy
  has_many :alerts, dependent: :destroy
  has_many :milestones, dependent: :destroy
  has_many :tasks, through: :milestones
  has_many :users_as_billers, through: :assignments, source: :user

  # little method to return a formatted string instead of a plain integer
  def estimated_cost_formatted
    formatter(estimated_cost)
  end

  def executed_cost_formatted
    formatter(tasks.sum(:value))
  end

  def hours_spent_formatted
    formatter(tasks.sum(:hours_spent))
  end

  # cost per hour on average

  def cost_per_hour
    tasks.sum(:value) / tasks.sum(:hours_spent)
  end

  # auto calculate budget percentage -- returns integer between 0 and 100

  def executed_budget_percentage
    (tasks.sum(:value).fdiv(estimated_cost) * 100).to_i
  end

  # auto calculate progress in time percentage -- returns integer between 0 and 100

  def progress_date_percentage
    remaining_days = (estimated_end_date - Date.today).to_i
    total_days = (estimated_end_date - estimated_start_date).to_i
    100 - (remaining_days.fdiv(total_days) * 100).to_i
  end

  # returns array with outstanding alerts

  def outstanding_alerts
    alerts.where(done: false)
  end

  private

  def formatter(int)
    int.to_s.reverse.scan(/\d{3}|.+/).join(".").reverse
  end
end
