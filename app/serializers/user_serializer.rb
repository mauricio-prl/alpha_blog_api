# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :admin

  has_many :articles
end
