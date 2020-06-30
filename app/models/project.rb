class Project < ApplicationRecord
  validates :name, :description, :estimated_start_date, :estimated_end_date, :estimated_cost, presence: true
  belongs_to :user
  has_many :assignments, dependent: :destroy
  has_many :alerts, dependent: :destroy
  has_many :milestones, dependent: :destroy
  has_many :tasks, through: :milestones
  has_many :users_as_billers, through: :assignments, source: :user
end
