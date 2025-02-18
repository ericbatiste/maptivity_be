class API::V1::AuthController < ApplicationController
  skip_before_action :authorize_request, only: [ :login ]

  # POST /login
  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      access_token = JsonWebToken.encode({ user_id: user.id })
      refresh_token = user.generate_refresh_token
      render json: { access_token:, refresh_token: }
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  # POST /refresh
  def refresh
    user = User.find_by(refresh_token: params[:refresh_token])

    if user
      access_token = JsonWebToken.encode({ user_id: user.id })
      render json: { access_token: }
    else
      render json: { error: "Invalid refresh token" }, status: :unauthorized
    end
  end

  # DELETE /logout
  def logout
    current_user.revoke_refresh_token
    render json: { message: "Logged out successfully" }
  end
end
