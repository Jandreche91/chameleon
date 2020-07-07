class MilestonesController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @milestone = Milestone.new(milestone_params)
    @milestone.project = @project
    @milestone.progress_rate = 0
    redirect_to project_path(@project) if @milestone.save
  end

  private

  def milestone_params
    params.require(:milestone).permit(:description, :end_date, :progress_rate)
  end
end
