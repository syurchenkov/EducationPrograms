require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  context 'GET new' do 
    it 'renders sessions#new' do 
      get :new 
      should respond_with(:success)
      should render_template('sessions/new')
    end
  end

  context 'POST create' do 
    context 'registered user' do 
      let!(:user) { create(:user) }
      let(:params) { { session: { email: user.email, password: 'password' } } }

      context 'sends request' do 
        before { post :create, params: params } 

        it 'redirects to user page' do 
          should respond_with(:redirect)
        end

        it 'sets session' do 
          should set_session[:user_id].to(user.id)
        end
      end
    end

    context 'not registered user' do
      let!(:user) { build(:user) }
      let(:params) { { session: { email: user.email, password: 'password' } } }

      context 'sends request' do 
        before { post :create, params: params }

        it 'renders new template' do 
          should render_template('sessions/new')
        end

        it 'sets flash' do 
          should set_flash.now[:danger]
        end
      end
    end
  end

  context 'DELETE destroy' do 
    context 'logged user' do 
      let!(:user) { create(:user) }
      before { @request.session[:user_id] = user.id }

      context 'sends delete request' do 
        before { delete :destroy }

        it 'redirects to login_url' do 
          should redirect_to login_url
        end

        it 'does not set session ' do 
          should_not set_session[:user_id]
        end
      end
    end
  end
end
