class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  helper_method :raise_error

  def raise_error(error_msg, status_code)
    render json: {error: error_msg}, status: status_code
  end

  # Change to display all API endpoints + descriptions
  def root
    config = YAML.load_file("config/config.yml")
    render json: config
  end

  private
  def authenticate
    if session[:user]
      if User.exists?(session_token: session[:user])
        @user = User.where(session_token: session[:user]).take
      else
        render nothing: true, status: :unauthorized
      end
    else
      authenticate_or_request_with_http_token do |token, options|
        @user = User.where(session_token: token).first
      end
    end
  end
end
