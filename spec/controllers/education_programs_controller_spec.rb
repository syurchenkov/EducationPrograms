require 'rails_helper'

RSpec.describe EducationProgramsController, type: :controller do
  let!(:education_program){ create(:education_program) } 
  let!(:user) { create(:user) }
  let!(:admin) { create(:admin) }

  context 'when not logged in user' do
    context 'get show education program' do 
      before{ get :show, params: { id: education_program.id } }

      it 'redirects to login page' do 
        should redirect_to login_path
      end
    end

    context 'get index education programs' do 
      before{ get :index }

      it 'redirects to login page' do 
        should redirect_to login_path
      end
    end
  end

  context 'when logged in user' do 
    before{ @request.session[:user_id] = user.id }

    context 'is trying to view education program' do 
      before{ get :show, params: { id: education_program.id } }

      it 'renders template education_programs/show' do 
        should render_template 'education_programs/show'
      end
    end

    context 'is trying to remove education program' do 
      before{ get :destroy, params: { id: education_program.id } }

      it 'renders template education_program/show' do 
        should redirect_to user
      end
    end
  end

  context 'when admin' do 
    before{ @request.session[:user_id] = admin.id }

    context 'is trying to view education program' do 
      before{ get :show, params: { id: education_program.id } }

      it 'renders template education_programs/show' do 
        should render_template 'education_programs/show'
      end

      it 'assigns education_program' do 
        expect(assigns(:education_program)).to eq(education_program)
      end
    end

    context 'is trying to view education programs' do 
      before{ get :index } 

      it 'renders template education_programs/index' do 
        should render_template 'education_programs/index'
      end
    end

    context 'is trying to view new education program' do 
      before{ get :new }

      it 'assigns education_program variable' do 
        expect(assigns(:education_program)).to be_a_new(EducationProgram)
      end
    end

    context 'is trying to create new valid education program' do 
      let!(:valid_education_program_attributes){ attributes_for(:education_program) }

      it 'increase number of education programs' do 
        expect do 
          post :create, params: { education_program: valid_education_program_attributes}
        end.to change{ EducationProgram.count }.by(1)
      end
    end

    context 'is trying to remove education program' do 
      let!(:education_program_to_destroy){ create(:education_program) }

      it 'changes education programs count by -1' do 
        expect do 
          delete :destroy, params: { id: education_program_to_destroy.id }
        end.to change{ EducationProgram.count }.by(-1)
      end
    end 
  end

end
