class UsersController < ApplicationController


  def create
    user = User.create!(user_params)

      session[:user_id] = user.id
      render json: user, status: :created

  end

  def show
    if session[:user_id]
      user = User.find(session[:user_id])
      render json: user, status: :created
    else
      render json: {error: "Unauthorized"}, status: :unauthorized
    end

  end

  private

  def user_params
    params.permit(:username, :password, :image_url, :bio, :password_confirmation)
  end
end
