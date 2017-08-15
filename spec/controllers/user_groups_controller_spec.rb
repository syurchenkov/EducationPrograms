require 'rails_helper'

RSpec.describe UserGroupsController, type: :controller do
  let!(:user){ create(:user) }
  let!(:admin){ create(:admin) }
  let!(:group) { create(:group) }

  context 'when not logged user' do 
    let!(:user_group){ create(:user_group) }

    context 'trying add user to group' do 
      it 'not add new user_group relation' do 
        expect do 
          delete :create, params: { user_group: { user_id: user.id, group_id: group.id } } 
        end.to_not change{ UserGroup.count }
      end
    end

    context 'trying remove user from group' do 
      it 'not remove user_group relation' do 
        expect do 
          delete :destroy, params: { id: user_group.id }
        end.to_not change{ UserGroup.count }
      end
    end
  end

  context 'when not admin' do 
    let!(:user_group){ create(:user_group) }
    before{ @request.session[:user_id] = user.id }

    context 'trying add user to group' do 
      it 'not add new user_group relation' do 
        expect do 
          post :create, params: { user_group: { user_id: user.id, group_id: group.id } } 
        end.to_not change{ UserGroup.count }
      end
    end

    context 'trying remove user from group' do 
      it 'not remove user_group relation' do 
        expect do 
          delete :destroy, params: { id: user_group.id }
        end.to_not change{ UserGroup.count }
      end
    end
  end

  context 'when admin' do 
    let!(:user_group){ create(:user_group) }
    before{ @request.session[:user_id] = admin.id }

    context 'trying add user to group' do 
      it 'add new user_group relation' do 
        expect do 
          post :create, params: { user_group: { user_id: user.id, group_id: group.id } } 
        end.to change{ UserGroup.count }.by(1)
      end
    end

    context 'trying add user to group when user already in group' do 
      it 'not add new user_group relation' do 
        expect do 
          post :create, params: { user_group: { user_id: user_group.user_id, group_id: user_group.group_id } } 
        end.to_not change{ UserGroup.count }
      end
    end

    context 'trying remove user from group' do 
      it 'remove user_group relation' do 
        expect do 
          delete :destroy, params: { id: user_group.id }
        end.to change{ UserGroup.count }.by(-1)
      end
    end
  end
end
