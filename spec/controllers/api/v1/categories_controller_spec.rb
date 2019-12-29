require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :controller do

  describe "GET #index" do
    it 'returns http status ok' do
      get :index 

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    context 'when invalid session' do
      it 'returns http status unauthorized' do
        post :create, params: { 
          session: {
            username: nil,
            password: nil
          },
          category: {
            name: 'New category'
          }
        }

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to match('There was something wrong, bad username or password.')
      end
    end

    context 'when user is not an admin' do
      let!(:not_admin) { create(:user) }

      it 'returns http status unauthorized' do
        post :create, params: { 
          session: {
            username: not_admin.username,
            password: not_admin.password
          },
          category: {
            name: 'New category'
          }
        }

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to match('Only admins can perform that action.')
      end
    end

    context 'when invalid attributes' do
      let!(:admin) { create(:user, admin: true) }

      it 'returnsh http status unprocessable_entity' do
        post :create, params: { 
          session: {
            username: admin.username,
            password: admin.password
          },
          category: {
            name: nil
          }
        }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when user is an admin and session is valid' do
      let!(:admin) { create(:user, admin: true) }

      it 'returns http status created' do
        post :create, params: { 
          session: {
            username: admin.username,
            password: admin.password
          },
          category: {
            name: 'New category'
          }
        }

        expect(response).to have_http_status(:created)
        expect(response.body).to match('Category successfully created.')
      end
    end
  end

  describe 'GET #show' do
    let!(:category) { create(:category) }

    it 'returns http status ok' do
      get :show, params: { id: category.id }

      expect(response).to have_http_status(:ok)
      expect(response.body).to match(category.name)
    end
  end

  describe "PUT #update" do
    let!(:category) { create(:category) }
    let!(:admin) { create(:user, admin: true) }
    let!(:not_admin) { create(:user) }

    context 'when invalid session' do
      it 'returns http status unauthorized' do
        put :update, params: { 
          session: {
            username: nil,
            password: nil
          },
          id: category.id,
          category: { name: 'Edited name' } 
        }

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to match('There was something wrong, bad username or password.')
      end
    end

    context 'when user is not an admin' do
      it 'returns http status unauthorized' do
        put :update, params: { 
          session: {
            username: not_admin.username,
            password: not_admin.password
          },
          id: category.id,
          category: { name: 'Edited name' } 
        }

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to match('Only admins can perform that action.')
      end
    end

    context 'when invalid attributes' do
      let!(:admin) { create(:user, admin: true) }

      it 'returns http status unprocessable_entity' do
        put :update, params: { 
          session: {
            username: admin.username,
            password: admin.password
          },
          id: category.id,
          category: { name: nil } 
        }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when user is an admin and session is valid' do
      it 'returns http status ok' do
        put :update, params: { 
          session: {
            username: admin.username,
            password: admin.password
          },
           id: category.id,
          category: { name: 'Edited name' } 
        }

        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:category) { create(:category) }
    let!(:not_admin) { create(:user) }
    let!(:admin) { create(:user, admin: true) }

    context 'when invalid session' do
      it 'returns http status unauthorized' do
        delete :destroy, params: { 
          session: {
            username: nil,
            password: nil
          },
          id: category.id,
        }

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to match('There was something wrong, bad username or password.')
      end
    end

    context 'when user is not an admin' do
      it 'returns http status unauthorized' do
        delete :destroy, params: { 
          session: {
            username: not_admin.username,
            password: not_admin.password
          },
          id: category.id,
        }

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to match('Only admins can perform that action.')
      end
    end

    context 'when user is an admin and session is valid' do
      it 'returns http status ok' do
        delete :destroy, params: { 
          session: {
            username: admin.username,
            password: admin.password
          },
          id: category.id,
        }

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
