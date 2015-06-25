class AssignmentsController < ApplicationController
  def index
    @assignment = Assignment.new
    @assignments = Assignment.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assignments}
    end
  end

  def show
    begin
      @assignment = Assignment.find_by(weekday: params[:id]) || Assignment.find(params[:id])
      render status: 200, json: @assignment.to_json
    rescue
      render status: 404, json: {error:"Not found.", documentation: "https://github.com/wdidc/api-assignment/blob/master/readme.md"}
    end
  end

  def create
    @assignment = Assignment.new(title: params[:title], weekday: params[:weekday], due_date: params[:due_date], repo_url: params[:repo_url], rubric_url: params[:rubric_url])
    if @assignment.save
      respond_to do |format|
        format.html
        format.json { render json: @assignment}
      end
    end
  end

  def update
    @assignment = Assignment.find_by(weekday: params[:id])
    if @assignment.update(title: params[:title], weekday: params[:weekday], due_date: params[:due_date], repo_url: params[:repo_url], rubric_url: params[:rubric_url])
      render json: @assignment.to_json, status: 200
    end
  end

  def destroy
    @assignment = Assignment.find_by(weekday: params[:id])
    if @assignment.destroy
      render json: @assignment.to_json, status: 200
    end
  end
end
