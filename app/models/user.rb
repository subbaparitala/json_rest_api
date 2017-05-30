class User < ApplicationRecord
  has_many :posts, dependent: :destroy 
  has_secure_token 
  has_secure_password

  validates :username, presence: true
end