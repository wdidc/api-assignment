class ApplicationController < ActionController::Base
  before_action :authenticate_user, except: [:authenticate]
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  after_filter :set_access_control_headers
  skip_before_filter :verify_authenticity_token
  before_action :authorize, only: [:create, :udpate, :delete]
  def set_access_control_headers
      headers['Access-Control-Allow-Origin'] = "*"
      headers['Access-Control-Request-Method'] = %w{GET POST OPTIONS}.join(",")
  end
  def authenticate
    token = request.env['omniauth.auth'][:credentials][:token]
    session[:token] = token
    if authorize
      redirect_to root_path
    else
      error json:{error: "not authorized"}
    end
  end
  private
  def authorize
    # get all instructors
    instructors = HTTParty.get("https://api.github.com/teams/1511667/members?access_token=#{params[:access_token]}")
    user = HTTParty.get("https://api.github.com/user?access_token=#{params[:access_token]}")
    begin
      instructors.each do |instructor|
        if user[:id] == instructor[:id]
          return true
        end
      end
    rescue
    end
    render json: {error: "not authorized"}
    # get user
    # if user == instructor continue with operation
    # else throw error
  end
  def authenticate_user
    unless session[:token]
      redirect_to '/auth/github'
    end
  end

end
