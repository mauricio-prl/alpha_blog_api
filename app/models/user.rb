# frozen_string_literal: true

class User < ApplicationRecord
  VALID_EMAIL_REGEX = /[\w+\-.]+@[\w+\-.]+\.[\w+]/i.freeze

  validates :username, presence: true, uniqueness: { case_sensitive: false },
    length: { minimum: 3, maximum: 25 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 100 },
    format: { with: VALID_EMAIL_REGEX }

  has_many :articles
end
