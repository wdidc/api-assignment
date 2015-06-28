class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
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
  private
  def authenticate_user!
    unless session[:token] && is_an_instructor?
      render json: {error:"Not Authorized"}
    end
  end
  def is_an_instructor?
    if session[:token]
    # get all instructors
    instructors = HTTParty.get("https://api.github.com/teams/1511667/members?access_token=#{session[:token]}")
    user = HTTParty.get("https://api.github.com/user?access_token=#{session[:token]}")
    begin
      instructors.each do |instructor|
        if user[:id] == instructor[:id]
          return true
        end
      end
    rescue
    end
    return false
    end
  end
end
