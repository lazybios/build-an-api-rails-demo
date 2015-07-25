class User < ActiveRecord::Base
  before_create :generate_authentication_token
  has_secure_password

  has_many :microposts

  def generate_authentication_token
    loop do
      self.authentication_token = SecureRandom.base64(64)
      break if !User.find_by(authentication_token: authentication_token)
    end
  end

  def reset_auth_token!
    generate_authentication_token
    save
  end
end
