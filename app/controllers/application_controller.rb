class ApplicationController < ActionController::API
  before_action :authorize_request

  private

  def authorize_request
    @current_user = User.find_by(id: request.env["current_user_id"])
    render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user
  end
end
