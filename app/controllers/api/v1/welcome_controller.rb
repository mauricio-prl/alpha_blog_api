# frozen_string_literal: true

class Api::V1::WelcomeController < ApplicationController
  def home
    render json: 'Welcome to Alpha Blog api!'
  end

  def about
    render json: 'This is a simple api for training.'
  end
end
