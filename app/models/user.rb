# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_ulid

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  has_many :projects, dependent: :destroy
end
