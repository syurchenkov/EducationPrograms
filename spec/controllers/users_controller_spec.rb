require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  context "GET new" do

    it "assigns a blank user to the view" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

  end

  context "POST create" do
    let!(:params){ { user: attributes_for(:user) } }

    def post_send_params
      post :create, params: params
    end
    
    it "renders new when new user is invalid" do 
      params[:user][:email] = 'user.ex.com'
      post_send_params
      should render_template 'users/new'
    end

    it "changes count of users by one" do 
      expect{ post_send_params }.to change{ User.count }.by(1)
    end

    it "set flash message" do 
      post_send_params
      should set_flash[:success]
    end

    it "redirects to user show when user is valid" do
      post_send_params
      should redirect_to(user_path(assigns(:user)))
    end
  end

  context 'when not logged in user' do 
    let!(:user) { create(:user) }


    context 'GET show' do
      let!(:params) { { id: user.id } }
      before { get :show, params: params }
      
      it 'redirects to login page' do 
        should redirect_to login_path
      end

      it 'set flash danger' do 
        should set_flash[:danger]
      end
    end

    context 'GET index' do 
      before { get :index } 

      it 'redirects to login page' do 
        should redirect_to login_path
      end

      it 'set flash danger' do 
        should set_flash[:danger]
      end
    end
  end

  context 'when logged in user' do 
    let!(:current_user){ create(:user) }
    let!(:other_user){ create(:user) }
    before{ @request.session[:user_id] = current_user.id }

    context 'GET show his own page' do 
      before{ get :show, params: { id: current_user.id } }

      it 'renders users/show template' do 
        should render_template 'users/show'
      end 
    end

    context 'GET show other user page' do 
      before{ get :show, params: { id: other_user.id } }

      it 'redirects to his own page' do 
        should redirect_to current_user
      end

      it 'set flash info' do 
        should set_flash[:info]
      end
    end

    context 'GET index' do 
      before{ get :index }

      it 'renders users/index template' do 
        should render_template 'users/index'
      end
    end
  end
end
