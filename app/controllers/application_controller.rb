class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protect_from_forgery :except => [:login]
  before_action :authenticate, only: [:logout]
  helper_method :raise_error

  def raise_error(error_msg, status_code)
    render json: {error: error_msg}, status: status_code
  end

  # Change to display all API endpoints + descriptions
  def root
    config = YAML.load_file("config/config.yml")
    render json: config
  end

  def login
    user = User.where(email: login_params['email']).take
    @user = user.authenticate(login_params['password'])
    if @user
      @user.generate_session_token
      render json: {session_token: @user.session_token}
    else
      render status: :unauthorized
    end
  end

  def logout
    @user.logout
    render nothing: true, status: :ok
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @user = User.where(session_token: token).first
    end
  end
end
