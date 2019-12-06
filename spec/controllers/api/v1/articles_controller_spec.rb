require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :controller do
  describe 'GET #index' do
    it 'returns http status ok' do
      get :index

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    context 'when valid attributes' do
      it 'returns http status created' do
        post :create, params: { article: attributes_for(:article) }

        expect(response).to have_http_status(:created)
      end
    end

    context 'when invalid attributes' do
      let(:article_params) { attributes_for(:article, title: nil) }

      it 'returns http status unprocessable_entity' do
        post :create, params: { article: article_params }

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
    context 'when valid attributes' do
      let!(:article) { create(:article) }

      it 'updates the article' do
        put :update, params: { id: article.id, article: attributes_for(:article) }

        expect(response).to have_http_status(:ok)  
      end
    end

    context 'when invalid attributes' do
      let!(:article) { create(:article) }
      let!(:invalid_article_params) { attributes_for(:article, title: nil) }

      it 'does not update the article' do
        put :update, params: { id: article.id, article: invalid_article_params }

        expect(response).to have_http_status(:unprocessable_entity) 
      end      
    end
  end

  describe 'DELETE #destroy' do
    let!(:article) { create(:article) }

    it 'deletes the article' do
      delete :destroy, params: { id: article.id }

      expect(response).to have_http_status(:ok)
    end
  end
end
