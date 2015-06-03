class CriteriaController < ApplicationController

  def index
    @assignment = Assignment.find_by(weekday: params[:assignment_id])
    @criteria = @assignment.criteria
    render status: 200, json: @criteria.to_json
  end

  def create
    @assignment = Assignment.find_by(weekday: params[:assignment_id])
    @criterium = @assignment.criteria.new(title: params[:title], body: params[:body])
    if @criterium.save
      render json: @criterium.to_json, status: 200
    end
  end

  def update
    @criterium = Criterium.find(params[:id])
    if @criterium.update(title: params[:title], body: params[:body])
      render json: @criterium.to_json, status: 200
    end
  end

  def destroy
    @criterium = Criterium.find(params[:id])
    if @criterium.destroy
      render json: @criterium.to_json, status: 200
    end
  end
end
