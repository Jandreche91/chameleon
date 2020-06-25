class Milestone < ApplicationRecord
  belongs_to :project
  has_many :tasks
  validates :description, :end_date, :progress_rate, presence: true
end
