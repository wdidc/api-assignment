class StudentsController < ApplicationController
  def index
    if params[:student_id]
      @submissions = Submission.where(github_id: params[:student_id], private: [nil,false])
    elsif params[:access_token]
      id = JSON.parse(HTTParty.get("https://api.github.com/user?access_token=" + params[:access_token]).body)["id"]
      @submissions = Submission.where(github_id: id, private: [nil,false])
    end
    render json: @submissions
  end
  def show
    @submission = Submission.where(assignment_id: params[:assignment_id], github_id: params[:student_id]).first
    render json: @submission
  end
end