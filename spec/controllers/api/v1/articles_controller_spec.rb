require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :controller do
  describe 'GET #index' do
    it 'returns http status ok' do
      get :index

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    let!(:user) { create(:user) }

    context 'when valid attributes' do  
      it 'returns http status created' do
        post :create, params: { 
          session: {
            username: user.username, password: user.password
          },
          article: {
            title: 'New article',
            description: 'New description'
          } 
        }

        expect(response).to have_http_status(:created)
      end
    end

    context 'when invalid session' do
      it 'returns unauthorized' do
        post :create, params: { 
          session: {
            username: user.username, password: nil
          },
          article: {
            title: 'New article',
            description: 'New description'
          } 
        }

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when invalid attributes' do
      let(:article_params) { attributes_for(:article, title: nil) }

      it 'returns http status unprocessable_entity' do
        post :create, params: { 
          session: {
            username: user.username, password: user.password
          },
          article: article_params 
        }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #show' do
    let!(:article) { create(:article) }

    it 'returns the http status ok' do
      get :show, params: { id: article.id }

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT #update' do
    let!(:user) { create(:user) }
    let!(:article) { create(:article, user: user) }

    context 'when valid attributes' do
      it 'returns http ok' do
        put :update, params: { 
          session: {
            username: user.username, password: user.password
          },
          id: article.id, article: attributes_for(:article) }

        expect(response).to have_http_status(:ok)  
      end
    end

    context 'when invalid session' do
      it 'returns http unauthorized' do
        put :update, params: { 
          session: {
            username: user.username, password: nil
          },
          id: article.id, article: attributes_for(:article) }

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to match('There was something wrong, bad username or password.')
      end
    end

    context 'when invalid attributes' do
      let!(:invalid_article_params) { attributes_for(:article, title: nil) }

      it 'return unprocessable_entity' do
        put :update, params: { 
          session: {
            username: user.username, password: user.password
          },
          id: article.id, article: invalid_article_params 
        }

        expect(response).to have_http_status(:unprocessable_entity) 
        expect(response.body).to match(/can't be blank/) 
      end      
    end

    context 'when user tries to edit an article from other user' do
      let!(:other_user) { create(:user) }

      it 'return unauthorized' do
        put :update, params: { 
          session: {
            username: other_user.username, password: other_user.password
          },
          id: article.id, article: attributes_for(:article) 
        }

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to match('You can only edit or destroy your own articles')
      end
    end

    context 'when user is an admin' do
      let!(:admin) { create(:user, admin: true) }

      it 'returns http status ok' do
        put :update, params: { 
          session: {
            username: admin.username, password: admin.password
          },
          id: article.id, article: attributes_for(:article) 
        }

        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create(:user) }
    let!(:article) { create(:article, user: user) }

    context 'when valid session and id' do
      it 'returns http status ok' do
        delete :destroy, params: { 
          session: { 
            username: user.username, 
            password: user.password 
          },
          id: article.id 
        }

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when invalid session' do
      it 'returns http status ok' do
        delete :destroy, params: { 
          session: { 
            username: user.username, 
            password: nil 
          },
          id: article.id 
        }

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user tries to delete an article from other user' do
      let!(:other_user) { create(:user) }

      it 'returns http status ok' do
        delete :destroy, params: { 
          session: { 
            username: other_user.username, 
            password: other_user.password
          },
          id: article.id 
        }

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user is an admin' do
      let!(:admin) { create(:user, admin: true) }

      it 'returns http status ok' do
        delete :destroy, params: { 
          session: { 
            username: admin.username, 
            password: admin.password
          },
          id: article.id 
        }

        expect(response).to have_http_status(:ok)
      end      
    end
  end
end
