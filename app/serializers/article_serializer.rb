# frozen_string_literal: true

class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :updated_at

  belongs_to :user
end
