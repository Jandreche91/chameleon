class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :project
  def name
    "#{self.user.username}"
  end
end
