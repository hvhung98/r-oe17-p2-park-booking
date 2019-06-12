class User < ApplicationRecord
  before_save :downcase_email
  belongs_to :role
  has_one :parking
  has_many :orders
  has_many :parkings, through: :orders, source: :orderable, source_type: "Parking"
  has_many :reviews
  has_many :parkings, through: :reviews
  has_attached_file :user_img, styles: {user_index: "250x250>", user_show: "240x160>"},
    default_url: "4.png"

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: [:google_oauth2]
  validates :name, presence: true, length: { maximum: Settings.name_max },
    uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length:
    { maximum: Settings.email_max }, format: { with: VALID_EMAIL_REGEX },
      uniqueness: { case_sensitive: false }
  validates_attachment_content_type :user_img, content_type: /\Aimage\/.*\z/

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

  def current_user? user
    self == user
  end

  private

  def downcase_email
    email.downcase!
  end
end
