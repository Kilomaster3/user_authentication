module UserValidatable
  VALID_PASSWORD_REGEX = /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/x.freeze
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  extend ActiveSupport::Concern
  included do
    validates :name, presence: true
    validates :surname, presence: true
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: VALID_EMAIL_REGEX }
    validates :password, presence: true, format: { with: VALID_PASSWORD_REGEX }
  end
end
