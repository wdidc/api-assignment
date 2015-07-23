class AssignmentsController < ApplicationController
  def index
    @assignment = Assignment.new
    @assignments = Assignment.order(due_date: :desc)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: Assignment.order(due_date: :desc) }
    end
  end

  def show
      @assignment = Assignment.find_by(weekday: params[:id]) || Assignment.find(params[:id])
      @submissions = @assignment.submissions.sort_by{ |s| s.student["squad"] }
      @issues = @assignment.issues session[:token]
      @students = Student.all
      respond_to do |format|
        format.html
        format.json { render json: @assignment}
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

  def edit
    @assignment = Assignment.find_by(weekday: params[:id]) || Assignment.find(params[:id])
  end

  def update
    @assignment = Assignment.find_by(weekday: params[:id]) || Assignment.find(params[:id])
    if @assignment.update(assignment_params)
      respond_to do |format|
        format.html {redirect_to assignment_path(@assignment)}
        format.json { render json: @assignment}
      end
    end
  end

  def destroy
    @assignment = Assignment.find_by(weekday: params[:id]) ||  Assignment.find(params[:id])
    if @assignment.destroy
      respond_to do |format|
        format.html {redirect_to assignments_path}
        format.json { render json: @assignment}
      end
    end
  end

  def outcomes
    @assignments = Assignment.where(assignment_type: "outcomes")
  end

  private
  def assignment_params
    params.require(:assignment).permit(:title, :weekday, :due_date, :repo_url, :rubric_url, :assignment_type)
  end
end
