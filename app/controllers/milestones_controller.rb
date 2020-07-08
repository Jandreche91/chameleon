class MilestonesController < ApplicationController
  before_action :find_a_project
  def create
    @milestone = Milestone.new(milestone_params)
    @milestone.project = @project
    @milestone.progress_rate = 0
    redirect_to project_path(@project) if @milestone.save
  end

  def update
    @milestone = Milestone.find(params[:id])
    if @milestone.update(milestone_params)
      redirect_to project_path(@project)
    end
  end

  private

  def find_a_project
    @project = Project.find(params[:project_id])
  end

  def milestone_params
    params.require(:milestone).permit(:description, :end_date, :progress_rate)
  end
end
