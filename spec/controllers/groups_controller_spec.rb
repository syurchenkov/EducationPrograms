require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let!(:group){ create(:group) } 
  let!(:user) { create(:user) }
  let!(:admin) { create(:admin) }

  context 'when not logged in user' do
    context 'get show group' do 
      before{ get :show, params: { id: group.id } }

      it 'redirects to login page' do 
        should redirect_to login_path
      end
    end

    context 'get index groups' do 
      before{ get :index }

      it 'redirects to login page' do 
        should redirect_to login_path
      end
    end
  end

  context 'when logged in user' do 
    before{ @request.session[:user_id] = user.id }

    context 'is trying to view group' do 
      before{ get :show, params: { id: group.id } }

      it 'renders template groups/show' do 
        should render_template 'groups/show'
      end
    end

    context 'is trying to remove group' do 
      before{ get :destroy, params: { id: group.id } }

      it 'redirects to user' do 
        should redirect_to user
      end
    end
  end

  context 'when admin' do 
    before{ @request.session[:user_id] = admin.id }

    context 'is trying to view group' do 
      before{ get :show, params: { id: group.id } }

      it 'renders template groups/show' do 
        should render_template 'groups/show'
      end

      it 'assigns group' do 
        expect(assigns(:group)).to eq(group)
      end
    end

    context 'is trying to view groups' do 
      before{ get :index } 

      it 'renders template groups/index' do 
        should render_template 'groups/index'
      end
    end

    context 'is trying to view new group' do 
      before{ get :new }

      it 'assigns group variable' do 
        expect(assigns(:group)).to be_a_new(Group)
      end
    end

    context 'is trying to create new valid group' do 
      let!(:valid_group_attributes){ attributes_for(:group) }

      it 'increase number of groups' do 
        expect do 
          post :create, params: { group: valid_group_attributes}
        end.to change{ Group.count }.by(1)
      end
    end

    context 'is trying to remove group' do 
      let!(:group_to_destroy){ create(:group) }

      it 'changes groups count by -1' do 
        expect do 
          delete :destroy, params: { id: group_to_destroy.id }
        end.to change{ Group.count }.by(-1)
      end
    end 
  end

end
