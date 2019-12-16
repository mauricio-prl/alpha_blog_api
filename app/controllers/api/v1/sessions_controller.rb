# frozen_string_literal: true

class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email])

    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      render json: "It's good to see you again #{user.username}.", status: :created
    else
      render json: 'There was something wrong, bad email or password...',
        status: :unprocessable_entity
    end
  end

  def destroy
    if params[:session][:user_id].blank?
      render json: 'This user is not logged in...', status: :unprocessable_entity
    else
      session[:user_id] = nil
      render json: 'Good bye, come back soon!'
    end
  end
end
