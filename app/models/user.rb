class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  scope :senior_associates, -> { where("hourly_rate > 400 AND hourly_rate < 700") }

  devise :database_authenticatable, :recoverable, :rememberable, :validatable
  has_many :projects
  has_many :assignments
  has_many :projects_per_associate, through: :assignments, source: :project
  has_many :tasks
  has_many :milestones_worked, through: :tasks, source: :milestone

  def assigned?(project)
    assignments.find_by(project: project).present?
  end

  def name
    "#{first_name} #{last_name}"
  end

  def total_hours_spent_per_project(project)
    tasks.includes(:milestone).where(milestones: { project: project }).sum(:hours_spent)
  end

  def total_hours_spent
    results = { projects: [], hours: [] }
    sorted_projects = projects_per_associate.map { |project| [project.name, total_hours_spent_per_project(project)] }.sort_by { |project_array| -project_array.last }
    sorted_projects.each do |project|
      results[:projects] << project[0]
      results[:hours] << project[1]
    end
    results.to_json
  end

  def past_projects
    a = total_projects_worked
    b = projects_per_associate
    (a - b) | (b - a)
  end

  def total_projects_worked
    array_of_projects = []
    milestones_worked.joins(:project).distinct.each do |milestone|
      array_of_projects << milestone.project
    end
    array_of_projects.uniq
  end
end
