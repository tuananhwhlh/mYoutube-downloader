class User < ApplicationRecord
  extend Enumerize

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  STATUSES = %w[active inactive].freeze
  ROLES = %w[admin client].freeze

  enumerize :role, in: ROLES, predicates: true, default: :client
  enumerize :status, in: STATUSES, predicates: { prefix: true }, default: :active

  validates :first_name, :last_name, presence: true
  validates :email, format: URI::MailTo::EMAIL_REGEXP
  validates :email, presence: true
end
