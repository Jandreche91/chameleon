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
    ['#7900B3', '#006BF0', '#338508', '#B30000', '#B37600', '#1E334D', '#FFC65A', '#00B392', '#AAEF68']
  end
end
