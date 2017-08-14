class EducationProgramsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user, except: [:show, :index]
  before_action :prepare_education_program, only: [:show, :edit, :update, :destroy]


  def index
    @education_programs = EducationProgram.paginate(page: params[:page])
  end

  def show
  end

  def new
    @education_program = EducationProgram.new
  end

  def create
    @education_program = EducationProgram.new(education_program_params)
    if @education_program.save 
      flash[:success] = 'New education program added!'
      redirect_to @education_program
    else 
      render 'new'
    end
  end

  def edit
  end

  def update
    if @education_program.update_attributes(education_program_params)
      flash[:success] = 'Education Program updated.'
      redirect_to @education_program
    else
      render 'edit'
    end
  end

  def destroy
    @education_program.destroy
    flash[:success] = 'Education Program deleted.'
    redirect_to education_programs_path
  end

  private

    def education_program_params
      params.require(:education_program).permit(:title, :content)
    end

    def prepare_education_program
      @education_program = EducationProgram.find(params[:id])
    end
end
