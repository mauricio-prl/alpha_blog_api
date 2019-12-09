require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'GET #index' do
    it 'returns http status ok' do
      get :index

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    context 'when valid attributes' do
      it 'returns http status created' do
        post :create, params: { user: attributes_for(:user) }

        expect(response).to have_http_status(:created)
      end
    end

    context 'when invalid attributes' do
      let(:user_params) { attributes_for(:user, username: nil) }

      it 'returns http status unprocessable_entity' do
        post :create, params: { user: user_params }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #show' do
    let!(:user) { create(:user) }

    it 'returns the http status ok' do
      get :show, params: { id: user.id }

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT #update' do
    let!(:user) { create(:user) }

    context 'when valid attributes' do
      it 'updates the user' do
        put :update, params: { id: user.id, user: attributes_for(:user) }

        expect(response).to have_http_status(:ok)  
      end
    end

    context 'when invalid attributes' do
      let!(:invalid_user_params) { attributes_for(:user, username: nil) }

      it 'does not update the user' do
        put :update, params: { id: user.id, user: invalid_user_params }

        expect(response).to have_http_status(:unprocessable_entity) 
      end      
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create(:user) }

    it 'deletes the user' do
      delete :destroy, params: { id: user.id }

      expect(response).to have_http_status(:ok)
    end
  end
end
