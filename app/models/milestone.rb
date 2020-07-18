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

  def self.generate_colors
    ['#B30000', '#006BF0', '#FFC65A', '#338508', '#1E334D', '#00B392', '#7900B3', '#AAEF68', '#B37600']
  end
end
