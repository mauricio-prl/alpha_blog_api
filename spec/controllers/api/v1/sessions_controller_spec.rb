require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  let!(:user) { create(:user) }
  
  describe "POST #create" do  
    context 'when user provides valid email and password' do  
      it 'returns http created' do
        post :create, params: { session: { email: user.email, password: user.password } }

        expect(response).to have_http_status(:created)
      end
    end

    context 'when user provides invalid email or password' do
      it 'returns http status unprocessable_entity' do
        post :create, params: { session: { email: user.email, password: nil } }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    context 'when session[:user_id] is valid' do
      it "returns http ok" do
        delete :destroy, params: { session: { user_id: user.id } }

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when session[:user_id] is invalid or nil' do
      it "returns http unprocessable_entity" do
        delete :destroy, params: { session: { user_id: nil } }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
