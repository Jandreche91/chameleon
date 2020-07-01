class Milestone < ApplicationRecord
  belongs_to :project
  has_many :tasks, dependent: :destroy
  validates :description, :end_date, :progress_rate, presence: true

  def executed_value
    sum = 0
    tasks.each do |task|
      sum += task.value
    end
    sum
  end

  def hours_spent
    tasks.sum(:hours_spent)
  end
end
