module Api
  module V1
    class ActivitiesController < ApplicationController
      before_action :set_activity, only: [ :show, :update, :destroy ]
      before_action :set_user, only: [ :index, :create ]

      # GET /api/v1/users/:id/activities
      def index
        render json: @user.activities
      end

      # GET /api/v1/users/:id/activities/:id
      def show
        render json: @activity
      end

      # POST /api/v1/users/:id/activities
      def create
        activity = @user.activities.new(activity_params)
        if activity.save
          render json: activity, status: :created
        else
          render json: { errors: activity.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/users/:id/activities/:id
      def update
        if @activity.update(activity_params)
          render json: @activity
        else
          render json: { errors: @activity.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/users/:id/activities/:id
      def destroy
        @activity.destroy
        head :no_content
      end

      private

      def set_activity
        @activity = @user.activities.find_by(id: params[:id])
        render json: { error: "Activity not found." }, status: :not_found unless @activity
      end

      def set_user
        @user = User.find_by(id: params[:user_id])
        render json: { error: "User not found." }, status: :not_found unless @user
      end

      def activity_params
        params.require(:activity).permit(
          :user_id,
          :title,
          :designation,
          :notes,
          :start_time,
          :end_time,
          :route,
          :distance
        )
      end
    end
  end
end
