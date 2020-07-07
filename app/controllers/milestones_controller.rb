class MilestonesController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @milestone = Milestone.new(milestone_params)
    @milestone.project = @project
    @milestone.progress_rate = 0
    @milestone.save
    redirect_to project_path(@project)
  end

  private

  def milestone_params
    params.require(:milestone).permit(:description, :end_date)
  end
end
