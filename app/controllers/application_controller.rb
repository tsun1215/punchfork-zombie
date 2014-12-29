class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :raise_error

  def raise_error(error_msg, status_code)
    render json: {error: error_msg}, status: status_code
  end

  # Change to display all API endpoints + descriptions
  def root
    @routes = []
    Rails.application.routes.routes.each do |route|
      route = route.path.spec.to_s
      @routes << route if route.starts_with?('/recipe')
    end
    render json: @routes
  end
end
