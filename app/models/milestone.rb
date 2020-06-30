class Milestone < ApplicationRecord
  belongs_to :project
  has_many :tasks, dependent: :destroy
  validates :description, :end_date, :progress_rate, presence: true
end
