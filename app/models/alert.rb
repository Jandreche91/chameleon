class Alert < ApplicationRecord
  belongs_to :project
  validates :description, presence: true

  def descriptions
    {
      budget_surpassed_85: "has surpassed 85 percent of the budget",
      budget_surpassed_50: "has surpassed 50 percent of the budget",
      progress_excess_time: "progress until end date is significantly higher than budget",
      progress_excess_budget: "budget spent is significantly higher than progress until end date",
      user_little_work: "is below the average billing time of your team",
      user_lots_works: "is above the average billing time of your team"
    }
  end

  def self.outstanding
    Alert.where(done: false)
  end

  def self.generate

  end
end
