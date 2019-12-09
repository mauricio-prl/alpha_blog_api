# frozen_string_literal: true

class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :description

  belongs_to :user
end
