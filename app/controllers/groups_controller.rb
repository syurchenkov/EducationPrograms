class GroupsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user, except: [:show, :index]
  before_action :prepare_group, only: [:show, :edit, :update, :destroy, :add_ep]

  def index 
    @groups = Group.paginate(page: params[:page])
  end

  def show 
    @users = @group.users.paginate(page: params[:page])
    @user_group = UserGroup.new(group: @group)
    @educational_relationship = EducationalRelationship.new()
    @education_programs = @group.education_programs
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

  def add_ep
    @education_program = EducationProgram.find(params[:educational_relationship][:education_program_id])
    @educational_relationship = EducationalRelationship.new(educational: @group, education_program: @education_program)
    if @educational_relationship.save 
      flash[:success] = 'Education program added'
      redirect_to @group
    else
      flash[:danger] = 'Can\'t add education program' 
      redirect_to @group
    end
  end

  private
    def group_params
      params.require(:group).permit(:title)
    end

    def prepare_group
      @group = Group.find(params[:id])
    end
end
