module Api
  class PostsController < ApplicationController
    def index
      posts = Post.all
      render json: posts
    end

    def show
      post = Post.find(params[:id])
      render json: post.as_json(include: :badges)
    end

    def create
      post = Post.new(post_params)
      if post.save
        # Handle badge_ids association
        if params[:badge_ids].present?
          badges = RailsBadgeable::Badge.where(id: params[:badge_ids])
          post.badges << badges
        end
        render json: post.as_json(include: :badges), status: :created
      else
        render json: { errors: post.errors }, status: :unprocessable_entity
      end
    end

    def update
      post = Post.find(params[:id])
      if post.update(post_params)
        # Handle badge_ids association - replace all badges
        if params.key?(:badge_ids)
          badges = RailsBadgeable::Badge.where(id: params[:badge_ids])
          post.badges = badges
        end
        render json: post.as_json(include: :badges)
      else
        render json: { errors: post.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      post = Post.find(params[:id])
      post.destroy
      head :no_content
    end

    # Get badges for a post
    def badges
      post = Post.find(params[:post_id])
      render json: post.badges
    end

    # Add a badge to a post
    def add_badge
      post = Post.find(params[:post_id])
      badge = RailsBadgeable::Badge.find(params[:badge_id])
      post.badges << badge
      render json: post.badges
    end

    # Remove a badge from a post
    def remove_badge
      post = Post.find(params[:post_id])
      badge = RailsBadgeable::Badge.find(params[:badge_id])
      post.badges.destroy(badge)
      render json: post.badges
    end

    private

    def post_params
      params.permit(:title, :content, badge_ids: [])
    end
  end
end
