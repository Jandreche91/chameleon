class Milestone < ApplicationRecord
  belongs_to :project
  has_many :tasks, dependent: :destroy
  validates :description, :end_date, :progress_rate, presence: true

  def executed_value
    tasks.sum(:value)
  end

  def hours_spent
    tasks.sum(:hours_spent)
  end
end
