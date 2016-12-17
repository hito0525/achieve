class UsersController < ApplicationController
before_action :authenticate_user!
before_action :correct_user, only: [:edit,:update]
before_action :set_user, only: [:show, :edit, :update, :like_blogs]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @followed_users = @user.followed_users
    @followers = @user.followers
    @blogs = @user.blogs
  end

  def edit
  end

  def update

  end

  def like_blogs
    @blogs = @user.like_blogs
    @title = "いいね！一覧"
    render :show
  end

  private

    def set_user
    @user= User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email)
    end

    def correct_user
      user = User.find(params[:id])
      if !current_user?(user)
        redirect_to root_path, alert: '許可されてないページです'
      end
    end
end
