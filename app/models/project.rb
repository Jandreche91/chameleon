class Project < ApplicationRecord
  validates :name, :description, :estimated_start_date, :estimated_end_date, :estimated_cost, presence: true
  belongs_to :user
  has_many :assignments
  has_many :alerts
  has_many :milestones
end
