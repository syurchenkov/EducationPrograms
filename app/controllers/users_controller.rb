class UsersController < ApplicationController
  before_action :logged_in_user, only: :index
  before_action :correct_user, only: :show
  before_action :admin_user, only: :add_ep

  def show
    @groups = @user.groups
    @educational_relationship = EducationalRelationship.new()
    @education_programs = @user.education_programs
    @group_education_programs = @user.groups.map{ |group| group.education_programs }.flatten
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

  def add_ep
    @user = User.find(params[:id])
    @education_program = EducationProgram.find(params[:educational_relationship][:education_program_id])
    @educational_relationship = EducationalRelationship.new(educational: @user, education_program: @education_program)
    if @educational_relationship.save 
      flash[:success] = 'Education program added'
      redirect_to @user
    else
      flash[:danger] = 'Can\'t add education program' 
      redirect_to @user
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
