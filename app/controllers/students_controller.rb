class StudentsController < ApplicationController
  def index
  end
  def show
    @submission = Submission.where(assignment_id: params[:assignment_id], github_id: params[:student_id]).first
    render json: @submission
  end
end