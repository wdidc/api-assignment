class AssignmentsController < ApplicationController
  def index
    @assignments = Assignment.all
    render status: 200, json: @assignments.to_json
  end

  def show
    @assignment = Assignment.find_by(weekday: params[:id])
    render status: 200, json: @assignment.to_json
  end

  def create
    @assignment = Assignment.new(title: params[:title], weekday: params[:weekday], end_date: params[:end_date], repo_url: params[:repo_url], rubric_url: params[:rubric_url])
    if @assignment.save
      render json: @assignment.to_json, status: 200
    end
  end

  def update
    @assignment = Assignment.find(params[:id])
    if @assignment.update(title: params[:title], weekday: params[:weekday], end_date: params[:end_date], repo_url: params[:repo_url], rubric_url: params[:rubric_url])
      render json: @assignment.to_json, status: 200
    end
  end

  def destroy
    @assignment = Assignment.find(params[:id])
    if @assignment.destroy
      render json: @assignment.to_json, status: 200
    end
  end

  private
  def homework_params
    params.require(:assignment).permit(:title, :weekday, :end_date, :repo_url, :rubric_url)
  end
end
