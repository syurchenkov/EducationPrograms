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

  context "GET show" do 
    let!(:user) { create(:user) }
    let!(:params) { { id: user.id } }

    it "assigns user variable" do 
      get :show, params: params
      expect(assigns(:user)).to eq(user)
    end
  end

  context 'GET index' do
    let!(:user) { create(:user) } 
    before { get :index }

    it 'assigns users variable' do 
      expect(assigns(:users)).to include(User.first)
    end
  end
end
