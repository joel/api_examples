# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: false do |t|
      t.string :id, index: { unique: true }, primary_key: true
      t.string :first_name
      t.string :last_name
      t.string :email, null: false, index: { unique: true }
      t.string :username, null: false, index: { unique: true }
      t.string :password_digest
      t.string :api_version

      t.timestamps
    end
  end
end
