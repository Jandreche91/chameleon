class Task < ApplicationRecord
  belongs_to :user
  belongs_to :milestone
  validates :description, :date, :hours_spent, :value, presence: true
end
