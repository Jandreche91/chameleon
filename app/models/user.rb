class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  scope :senior_associates, -> { where("hourly_rate > 400 AND hourly_rate < 700") }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :projects
  has_many :assignments
  has_many :tasks

  def is_assigned?(project)
    assignments.find_by(project: project).present?
  end

  def name
    "#{first_name} #{last_name}"
  end
end
