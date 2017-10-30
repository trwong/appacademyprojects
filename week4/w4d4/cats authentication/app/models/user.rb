class User < ApplicationRecord
  validates :username, presence: true
  validates :password_digest, presence: true
  validates :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  has_many :cats,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :Cat

  has_many :requests,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :CatRentalRequest

 attr_reader :password

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
     self.session_token = SecureRandom::urlsafe_base64(16)
    #  self.save
     self.session_token
  end

  def password=(password)
    @password=password
    self.password_digest=BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  def self.find_by_credentials(username, password)
    user=User.find_by(username: username)
    if ( user.nil?)
      nil
    elsif (user.is_password?(password))
        return user
    end
  end

end
