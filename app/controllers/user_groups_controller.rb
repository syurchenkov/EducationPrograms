class UserGroupsController < ApplicationController  
  before_action :logged_in_user
  before_action :admin_user, except: [:show, :index]

  def create
    @user_group = UserGroup.new(user_group_params)
    if @user_group.save 
      flash[:success] = 'User added to group'
      redirect_to @user_group.group
    else
      flash[:danger] = 'Can\'t add user to group'
      redirect_back(fallback_location: current_user)
    end
  end

  def destroy 
    @user_group = UserGroup.find(params[:id])
    @user_group.destroy
    flash[:success] = 'User removed from group'
    redirect_back(fallback_location: @user_group.group)
  end

  private 
    def user_group_params
      params.require(:user_group).permit(:user_id, :group_id)
    end
end
