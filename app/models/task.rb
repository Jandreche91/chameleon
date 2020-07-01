class Task < ApplicationRecord
  belongs_to :user
  belongs_to :milestone
  validates :description, :date, :hours_spent, presence: true

  def value
    User.find(user_id).hourly_rate * hours_spent
  end
end
