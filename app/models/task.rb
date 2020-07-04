class Task < ApplicationRecord
  belongs_to :user
  belongs_to :milestone
  validates :description, :date, :hours_spent, :value, presence: true

  # class method giving access to values per month over the past year, returns a hash with a hash per month

  def self.past_year
    results = { value: [], hours_spent: [] }
    end_time = Date.today
    12.times do
      start_time = end_time - 30
      results[:value] << Task.where(date: start_time..end_time).sum(:value)
      results[:hours_spent] << Task.where(date: start_time..end_time).sum(:hours_spent)
      end_time = start_time
    end
    results[:value].reverse!
    results[:hours_spent].reverse!
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
