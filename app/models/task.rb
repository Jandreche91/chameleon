class Task < ApplicationRecord
  belongs_to :user
  belongs_to :milestone
  validates :description, :date, :hours_spent, :value, presence: true

  # class method giving access to values per month over the past year, returns a hash with a hash per month

  def self.past_year
    results = {}
    end_time = Date.today
    12.times do |x|
      start_time = end_time - 30
      results[(x + 1).to_s] = { value: Task.where(date: start_time..end_time).sum(:value),
                                hours_spent: Task.where(date: start_time..end_time).sum(:hours_spent) }
      end_time = start_time
    end
    results
  end

  # def self.a_month
  #   Task.where(date: Date.today - 30..Date.today)
  # end

  # def self.six_month
  #   Task.where(date: Date.today - 180..Date.today)
  # end

  # def self.a_year
  #   Task.where(date: Date.today - 365..Date.today)
  # end
end
