class RecipesController < ApplicationController

  def index
    if session[:user_id]
      recipes = Recipe.all
      render json: recipes, include: :user, status: :created
    else
      render json: { errors: [] }, status: :unauthorized
    end
  end

  def create
    if session[:user_id]
      filtered_params = recipe_params
      filtered_params[:user_id] = session[:user_id]

      recipe = Recipe.create!(filtered_params)
      render json: recipe, include: :user, status: :created
    else
      render json: { errors: [] }, status: :unauthorized
    end
    end

  private

  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end

end
