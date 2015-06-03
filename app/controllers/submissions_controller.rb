class SubmissionsController < ApplicationController

  def index
    @assignment = Assignment.find_by(weekday: params[:assignment_id])
    @submissions = @assignment.submissions
    render status: 200, json: @submissions.to_json
  end

  def create
    @submission  = Submission.new(github_id: params[:github_id], criterium_id: params[:criterium_id], html_url: params[:html_url], repo_url: params[:repo_url], status: params[:status])
    if @submission.save
      render json: @submission.to_json, status: 200
    end
  end

  def update
    @submission = Submission.find(params[:id])
    if @submission.update(github_id: params[:github_id], html_url: params[:html_url], repo_url: params[:repo_url], status: params[:status])
      render json: @submission.to_json, status: 200
    end
  end

  def destroy
    @submission = Submission.find(params[:id])
    if @submission.destroy
      render json: @submission.to_json, status: 200
    end
  end
end
