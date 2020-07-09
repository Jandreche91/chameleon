class AssignmentsController < ApplicationController
  def index
    @projects = Project.all
  end
end
