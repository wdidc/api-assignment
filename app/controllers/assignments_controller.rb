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
      @submissions = @assignment.submissions
      respond_to do |format|
        format.html
        format.json { render json: @assignment}
      end
    rescue
      render status: 404, json: {error:"Not found.", documentation: "https://github.com/wdidc/api-assignment/blob/master/readme.md"}
    end
  end

  def create
    @assignment = Assignment.new(assignment_params)
    if @assignment.save
      respond_to do |format|
        format.html {redirect_to assignments_path}
        format.json { render json: @assignment}
      end
    end
  end

  def update
    @assignment = Assignment.find_by(weekday: params[:id])
    if @assignment.update(assignment_params)
      render json: @assignment.to_json, status: 200
    end
  end

  def destroy
    @assignment = Assignment.find_by(weekday: params[:id])
    if @assignment.destroy
      render json: @assignment.to_json, status: 200
    end
  end

  def authenticate
    token = request.env['omniauth.auth'][:credentials][:token]
    session[:token] = token
    if session[:token]
      redirect_to root_path
    else
      error json:{error: "not authorized"}
    end
  end

  private
  def assignment_params
    params.require(:assignment).permit(:title, :weekday, :due_date, :repo_url, :rubric_url)
  end
end
