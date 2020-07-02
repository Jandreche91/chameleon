class Alert < ApplicationRecord
  belongs_to :project
  validates :description, presence: true

  def self.outstanding
    Alert.where(done: false)
  end
end
