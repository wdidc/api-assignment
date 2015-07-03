class ApplicationController < ActionController::Base
  after_filter :set_access_control_headers
  skip_before_filter :verify_authenticity_token
  before_action :authenticate_user!, only: [:destroy,:update,:create]

  def set_access_control_headers
      headers['Access-Control-Allow-Origin'] = "*"
      headers['Access-Control-Request-Method'] = %w{GET POST OPTIONS}.join(",")
  end

  def logout
    session.clear
    redirect_to root_path
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
  def authenticate_user!
    unless is_an_instructor? || has_api_token?
      render json: {error:"Not an instructor"}
    end
  end

  def has_api_token?
    params[:api_token] && params[:api_token] == ENV["ASSIGNMENTS_API_TOKEN"]
  end

  def is_an_instructor?
    return false unless session[:token]
    begin
      # get all instructors
      instructors = JSON.parse(HTTParty.get("https://api.github.com/teams/1511667/members?access_token=#{session[:token]}").body)
      user = HTTParty.get("https://api.github.com/user?access_token=#{session[:token]}")
      return true if instructors.map{|i|i["id"]}.include? user["id"]
    rescue
    end
  end

end
