class SubmissionsController < ApplicationController
  def index
    @assignment = Assignment.find_by(weekday: params[:assignment_id]) || Assignment.find(params[:assignment_id])
    @students = Student.all
    @submissions = @assignment.submissions
    respond_to do |format|
      format.html
      format.json { render status: 200, json: @submissions.to_json }
    end
  end

  def new
    @assignment = Assignment.find_by(weekday: params[:assignment_id]) || Assignment.find(params[:assignment_id])
    @students = Student.all
    @submissions = @assignment.submissions
    respond_to do |format|
      format.html
      format.json { render status: 200, json: @submissions.to_json }
    end

  end

  def show
    @assignment = Assignment.find_by(weekday: params[:assignment_id]) || Assignment.find(params[:assignment_id])
    @submissions = @assignment.submissions
    @submission = Submission.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render status: 200, json: @submissions.to_json }
    end
  end

  def create
    @assignment = Assignment.find(params[:assignment_id])
    @submission  = @assignment.submissions.new(submission_params)
    if @submission.save
      respond_to do |format|
        format.html {redirect_to assignment_submissions_path(@assignment) }
        format.json {render json: @assignment}
      end
    end
  end

  def update
    @submission = Submission.find(params[:id])
    if @submission.update(submission_params)
      render json: @submission.to_json, status: 200
    end
  end

  def destroy
    @submission = Submission.find(params[:id])
    if @submission.destroy
      render json: @submission.to_json, status: 200
    end
  end
  private
  def submission_params
    params.require(:submission).permit(:github_id, :html_url, :repo_url, :status)
  end
end
