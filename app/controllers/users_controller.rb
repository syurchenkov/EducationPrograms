class UsersController < ApplicationController
  before_action :logged_in_user, only: :index
  before_action :correct_user, only: :show

  def show
    @groups = @user.groups
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Welcome!'
      redirect_to @user
    else 
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user) || (logged_in? && current_user.admin?)
        if logged_in?
          flash[:info] = 'You don\'t have permission.'
          redirect_to(current_user)
        else 
          flash[:danger] = 'Please log in.' 
          redirect_to(login_url) 
        end
      end
    end
end
