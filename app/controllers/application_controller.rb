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
    if is_an_instructor?
      return true
    end
    unless has_api_token?
      render json: {error:"Missing valid api token"}
      return
    end
  end

  def has_api_token?
    params[:api_token] && params[:api_token] == ENV['assignments_api_token']
  end

  def is_an_instructor?
    token = session[:token] || params[:access_token]
    return false unless token
    begin
      # get all instructors
      instructors = JSON.parse(HTTParty.get("https://api.github.com/teams/1511667/members?access_token=#{token}").body)
      user = HTTParty.get("https://api.github.com/user?access_token=#{token}")
      return true if instructors.map{|i|i["id"]}.include? user["id"]
    rescue
    end
  end

end
