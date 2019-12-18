# frozen_string_literal: true

class Api::V1::ArticlesController < ApplicationController
  before_action :set_article, only: %i[show update destroy]
  before_action :authenticate_user, except: %i[index show]
  before_action :require_owner, only: %i[update destroy]

  def index
    render json: Article.order(:id)
  end

  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      render json: @article, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @article
  end

  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    render json: @article
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :user_id)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def require_owner
    unless @article.user == current_user
      render json: 'You can only edit or destroy your own articles', status: :unauthorized
    end
  end
end
