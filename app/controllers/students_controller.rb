class StudentsController < ApplicationController
  before_filter :authorize_instructor!
  
  def index
    @students =Student.all
  end

  def show
    @student = Student.find(params[:id])
  end
end
