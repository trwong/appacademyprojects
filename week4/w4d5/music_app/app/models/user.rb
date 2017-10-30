class User < ApplicationRecord
  attr_accessor :password

  after_initialize :generate_session_token

  validates :email, :password_digest, :session_token, presence: true
  validates :email, :session_token, uniqueness: true
  validates :password_digest, presence: { message: "Password cannot be blank" }
  validates :password, length: { minimum: 6, allow_nil: true }

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save
    self.session_token
  end

  def generate_session_token
    self.session_token ||= User.generate_session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def User.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil unless user
    return user if user.is_password?(password)
    nil
  end
end
