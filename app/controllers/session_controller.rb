class SessionController < ApplicationController
  before_action :authenticate, except: [:login]

  def login
    u = User.where(email: login_params['email']).take
    @user = u.authenticate(login_params['password'])
    if @user
      @user.generate_session_token
      session[:user] = @user.session_token
      render json: {session_token: @user.session_token}
    else
      render status: :unauthorized
    end
  end

  def logout
    session[:user] = nil
    @user.logout
    render nothing: true, status: :ok
  end

  private
  def login_params
    params.permit(:email, :password)
  end
end
