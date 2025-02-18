class ApplicationController < ActionController::API
  before_action :authorize_request

  attr_reader :current_user

  private

  def authorize_request
    header = request.headers["Authorization"]
    return if header.blank?

    token = header.split(" ").last
    decoded = JsonWebToken.decode(token)

    if decoded
      @current_user = User.find_by(id: decoded[:user_id])
    else
      render json: { error: "Invalid or expired token" }, status: :unauthorized
    end
  end
end
