# frozen_string_literal: true

class Project < ApplicationRecord
  has_ulid

  belongs_to :user

  validates :name, presence: true
end
