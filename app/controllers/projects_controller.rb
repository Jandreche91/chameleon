class ProjectsController < ApplicationController
  before_action :find_a_project, only: [:show, :edit, :update]

  def index
    @projects = Project.all
    @outstanding_alerts = Alert.outstanding
    @dashboard_data = Task.past_year
    @array_of_projects = Project.id
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    @project.save
    redirect_to project_path(@project)
  end

  def show
    # projects
    @cummulative_value = @project.hash_cummulative_value
    @milestone_names = @project.milestone_names
    # Add unassingned to the above array to take into account possible unassigned portions of budget
    @milestones_names << "Unassigned" unless @project.unassigned_progress_rate.zero?
    @milestone_values = @project.hash_milestone_estimated_cummulative_value
    @milestone = Milestone.new
  end

  def edit
  end

  def update
    @project.update(project_params)
    redirect_to project_path(@project)
  end

  # Projects should only be destroyed by admin
  # def destroy
  #   @project.destroy
  #   redirect_to projects_path
  # end

  private

  def find_a_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :estimated_start_date, :estimated_end_date, :estimated_cost)
  end
end
