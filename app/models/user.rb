require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest.new('SHA256')
  VALID_USERNAME_REGEXP = /\A\w+\z/
  VALID_BG_COLOR_REGEXP = /\A#([a-f0-9]){6}\z/

  before_validation :username_downcase, :email_downcase

  before_save :encrypt_password

  has_many :questions, dependent: :destroy

  attr_accessor :password

  validates :bg_color, allow_blank: true, format: { with: VALID_BG_COLOR_REGEXP }

  validates :email, :username, presence: true, uniqueness: true

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password, confirmation: true, presence: true, on: :create

  validates :username, format: { with: VALID_USERNAME_REGEXP }, length: { maximum: 40 }

  def self.authenticate(email, password)
    user = find_by(email: email&.downcase)

    return nil unless user.present?

    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )

    return user if user.password_hash == hashed_password

    nil
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack1('H*')
  end

  private

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(password, password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  def email_downcase
    email.downcase! if email.present?
  end

  def username_downcase
    username.downcase! if username.present?
  end
end
