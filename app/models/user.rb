class User < ApplicationRecord
  belongs_to :role
  has_one :parking
  has_many :orders, dependent: :destroy
  has_many :parkings, through: :orders
  has_many :reviews
  has_many :parkings, through: :reviews

  before_save :downcase_email
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: [:google_oauth2]
  validates :name, presence: true, length: { maximum: Settings.name_max },
    uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length:
    { maximum: Settings.email_max }, format: { with: VALID_EMAIL_REGEX },
      uniqueness: { case_sensitive: false }

  class << self
    def from_omniauth(access_token)
      data = access_token.info
      user = User.find_by(email: data["email"])
      unless user
        password = Devise.friendly_token[0,20]
        user = User.create(name: data["name"], email: data["email"],
          password: password, password_confirmation: password)
      end
      user
    end
  end
  private

  def downcase_email
    email.downcase!
  end
end
