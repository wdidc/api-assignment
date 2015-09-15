class ApplicationController < ActionController::Base
  after_filter :set_access_control_headers
  skip_before_filter :verify_authenticity_token
  before_action :authorize_user!, except: [:authenticate]

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
  def authorize_user!
    return true if user_matches_student? || is_an_instructor? || has_api_token?

    render json: {error:"Missing valid api or access token"}
    return false
  end

  def authorize_instructor!
    return true if is_an_instructor? || has_api_token?

    render json: {error:"Not authorized to modify data."}
    return false
  end

  def user_matches_student?
    if params[:access_token] && params[:github_id]
      current_user_github_id = JSON.parse(HTTParty.get("https://api.github.com/user?access_token=" + params[:access_token]).body)["id"]
      return params[:github_id].to_i == current_user_github_id.to_i
    end
    return false
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
    rescue => err
      Rails.logger.error "ERR: Within ApplicationController#is_an_instructor?\n  #{err}"
      Rails.logger.debug "BACKTRACE: #{err.backtrace.join("\n")}\n"
    end
  end

  helper_method :is_an_instructor?
end
