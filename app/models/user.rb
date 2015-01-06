class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :first_name, presence: true
  validates :last_name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password

  has_many :recipe_references, dependent: :destroy

  def generate_session_token
    self.session_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.exists?(session_token: random_token)
    end
    self.save
  end

  def logout
    self.session_token = nil
    self.save
  end
end
