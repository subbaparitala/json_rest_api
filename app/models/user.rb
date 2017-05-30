class User < ApplicationRecord
  has_many :posts, dependent: :destroy 
  has_secure_token 
  has_secure_password

  validates :username, presence: true

  # This method is not available in has_secure_token
  def invalidate_token
    self.update_columns(token: nil)
  end

  def self.valid_login?(username, password)
    user = find_by(username: username)
    if user && user.authenticate(password)
      user
    end
  end
end