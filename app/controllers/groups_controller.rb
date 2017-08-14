class GroupsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user, except: [:show, :index]
  before_action :prepare_group, only: [:show, :edit, :update, :destroy]

  def index 
    @groups = Group.paginate(page: params[:page])
  end

  def show 
  end

  def new
    @group = Group.new
  end

  def create 
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = 'Group created'
      redirect_to @group
    else
      render 'new'
    end
  end

  def edit 
  end

  def update 
    if @group.update_attributes(group_params)
      flash[:success] = 'Group updated'
      redirect_to @group
    else
      render 'edit'
    end
  end

  def destroy
    @group.destroy
    flash[:success] = 'Group deleted'
    redirect_to groups_path
  end

  private
    def group_params
      params.require(:group).permit(:title)
    end

    def prepare_group
      @group = Group.find(params[:id])
    end
end
