class Api::V1::UsersController < ApplicationController
  # GET /api/v1/users/me
  def show
    render json: current_user
  end

  # PATCH/PUT /api/v1/users/me
  def update
    if current_user.update(user_params)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/me
  def destroy
    current_user.destroy
    head :no_content
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
