# frozen_string_literal: true

class ApplicationController < ActionController::API
  def authenticate_user
    unless current_user&.authenticate(params[:session][:password])
      render json: 'There was something wrong, bad username or password.', status: :unauthorized
    end
  end

  def current_user
    if params[:session] && params[:session][:username]
      @current_user ||= User.find_by(username: params[:session][:username])
    end
  end
end
