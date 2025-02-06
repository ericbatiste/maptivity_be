module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: [ :show, :update, :destroy ]

      # GET /api/v1/users
      def index
        users = User.all
        render json: users
      end

      # GET /api/v1/users/:id
      def show
        render json: @user
      end

      # POST /api/v1/users
      def create
        user = User.new(user_params)
        if user.save
          render json: user, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/users/:id
      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/users/:id
      def destroy
        @user.destroy
        head :no_content
      end

      private

      def set_user
        @user = User.find_by(id: params[:id])
        render json: { error: "User not found." }, status: :not_found unless @user
      end

      def user_params
        params.require(:user).permit(:name, :email)
      end
    end
  end
end
