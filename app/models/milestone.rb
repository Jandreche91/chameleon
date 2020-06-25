class Milestone < ApplicationRecord
  belongs_to :project
  validates :description, :end_date, :progress_rate, presence: true
end
