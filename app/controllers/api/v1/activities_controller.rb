class Api::V1::ActivitiesController < ApplicationController
  before_action :set_activity, only: [ :show, :update, :destroy ]

  # GET /api/v1/activities
  def index
    render json: current_user.activities
  end

  # GET /api/v1/activities/:id
  def show
    render json: @activity
  end

  # POST /api/v1/activities
  def create
    activity = current_user.activities.new(activity_params)
    if activity.save
      render json: activity, status: :created
    else
      render json: { errors: activity.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/activities/:id
  def update
    if @activity.update(activity_params)
      render json: @activity
    else
      render json: { errors: @activity.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/activities/:id
  def destroy
    @activity.destroy
    head :no_content
  end

  private

  def set_activity
    @activity = current_user.activities.find_by(id: params[:id])
    render json: { error: "Activity not found." }, status: :not_found unless @activity
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
      :distance,
      :max_speed,
      :average_speed,
      :climbing,
      :descending
    )
  end
end
