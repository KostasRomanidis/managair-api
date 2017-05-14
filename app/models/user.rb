class User < ApplicationRecord
  has_secure_password
  has_many :organizations, through: :user_organizations
  has_many :user_organizations
  validates_presence_of :name, :email, :password_digest
end
