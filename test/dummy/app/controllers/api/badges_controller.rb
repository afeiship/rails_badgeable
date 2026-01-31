module Api
  class BadgesController < ApplicationController
    def index
      badges = RailsBadgeable::Badge.all
      render json: badges
    end

    def show
      badge = RailsBadgeable::Badge.find(params[:id])
      render json: badge
    end

    def create
      badge = RailsBadgeable::Badge.new(badge_params)
      if badge.save
        render json: badge, status: :created
      else
        render json: { errors: badge.errors }, status: :unprocessable_entity
      end
    end

    def update
      badge = RailsBadgeable::Badge.find(params[:id])
      if badge.update(badge_params)
        render json: badge
      else
        render json: { errors: badge.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      badge = RailsBadgeable::Badge.find(params[:id])
      badge.destroy
      head :no_content
    end

    def assigned_to
      badge = RailsBadgeable::Badge.find(params[:id])
      model_class = params[:model_type].constantize
      records = badge.assigned_to(model_class)
      render json: records
    end

    private

    def badge_params
      params.permit(:name, :description)
    end
  end
end
