class Api::V1::AuthController < ApplicationController
  skip_before_action :authorize_request, only: [ :signup, :login, :refresh ]

  # POST /api/v1/auth/signup
  def signup
    user = User.new(user_params)

    if user.save
      token = JsonWebToken.encode(user_id: user.id)
      refresh_token = user.generate_refresh_token
      render json: { user: user, token: token, refresh_token: refresh_token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /api/v1/auth/login
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

  # POST /api/v1/auth/refresh
  def refresh
    user = User.find_by(refresh_token: params[:refresh_token])

    if user
      access_token = JsonWebToken.encode({ user_id: user.id })
      render json: { access_token: }
    else
      render json: { error: "Invalid refresh token" }, status: :unauthorized
    end
  end

  # DELETE /api/v1/auth/logout
  def logout
    current_user.revoke_refresh_token
    render json: { message: "Logged out successfully" }
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
