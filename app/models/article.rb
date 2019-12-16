# frozen_string_literal: true

class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3, maximum: 20 }
  validates :description, presence: true, length: { minimum: 5, maximum: 800 }

  belongs_to :user
end
