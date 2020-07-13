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
    if @project.save
      # users_assigned
      @users_assigned = params[:project][:user_id]
      create_assignments(@users_assigned, @project)
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def show
    # projects
    @cummulative_value = @project.hash_cummulative_value
    # @milestones_names << "Unassigned" unless @project.unassigned_progress_rate.zero?
    @milestone_values = @project.hash_milestone_estimated_cummulative_value
    @milestone_progress_rates = @project.hash_milestone_progress_rates
    @finished_milestones = @project.milestones.select { |m| m.done == true }
    @unfinished_milestones = @project.milestones.select { |m| m.done == false }
    @new_milestone = Milestone.new
  end

  def edit
  end

  def update
    raise
    @project.update(project_params)
    redirect_to project_path(@project)
  end

  # Projects should only be destroyed by admin
  # def destroy
  #   @project.destroy
  #   redirect_to projects_path
  # end

  private

  # users_assigned is an array of ids as strings
  def create_assignments(users_assigned, project)
    users_assigned.each do |user_id|
      next if user_id == ""

      assignment = Assignment.new
      assignment.user = User.find(user_id.to_i)
      assignment.project = project
      assignment.save
    end
  end

  def find_a_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :estimated_start_date, :estimated_end_date, :estimated_cost, :user_id)
  end

  def users_assigned
    params.require(:project).permit(:user_id)
  end
end
