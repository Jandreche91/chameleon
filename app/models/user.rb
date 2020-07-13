class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  scope :senior_associates, -> { where("hourly_rate > 400 AND hourly_rate < 700") }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :projects
  has_many :assignments
  has_many :projects_per_associate, through: :assignments, source: :project
  has_many :tasks

  def assigned?(project)
    assignments.find_by(project: project).present?
  end

  def name
    "#{first_name} #{last_name}"
  end

  def total_hours_spent(project)
    tasks.includes(:milestone).where(milestones: { project: project }).sum(:hours_spent)
  end
end
