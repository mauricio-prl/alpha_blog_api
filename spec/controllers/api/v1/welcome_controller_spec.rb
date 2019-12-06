require 'rails_helper'

RSpec.describe Api::V1::WelcomeController, type: :controller do

  describe "GET #home" do
    it "returns http success" do
      get :home

      expect(response).to have_http_status(:success)
      expect(response.body).to match('Welcome to Alpha Blog api!')
    end
  end

  describe "GET #about" do
    it "returns http success" do
      get :about

      expect(response).to have_http_status(:success)
      expect(response.body).to match('This is a simple api for training.')
    end
  end
end
