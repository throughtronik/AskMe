require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20000.freeze
  DIGEST = OpenSSL::Digest::SHA256.new
  VALID_USERNAME_REGEXP = /\A\w+\z/.freeze

  attr_accessor :password

  before_validation :username_downcase
  before_save :encrypt_password

  has_many :questions, dependent: :destroy

  # email, username presence
  validates :email, :username, presence: true
  # email, username uniqueness
  validates :email, :username, uniqueness: true
  # email format validation
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}

  validates :password, confirmation: true, presence: true, on: :create
  # max length of username
  validates :username, format: {with: VALID_USERNAME_REGEXP}, length: {maximum: 40}

  def self.authenticate(email, password)
    user = find_by(email: email)

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
    password_hash.unpack('H*')[0]
  end

  private

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  def username_downcase
    username.downcase!
  end
end
