# frozen_string_literal: true

class Api::V1::CategoriesController < ApplicationController
  before_action :set_category, except: %i[index create]
  before_action :authenticate_user, except: %i[index show]
  before_action :require_admin, except: %i[index show]

  def index
    render json: Category.order(:name)
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      render json: 'Category successfully created.', status: :created
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @category
  end

  def update
    if @category.update(category_params)
      render json: 'Category successfully updated'
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    render json: @category
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    unless current_user.admin?
      render json: 'Only admins can perform that action.', status: :unauthorized
    end
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
