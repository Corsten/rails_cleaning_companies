class Admin < ApplicationRecord
  extend Enumerize
  paginates_per 5

  has_many :article, dependent: :nullify

  LETTER_REGEX = /\A[а-яА-ЯёЁa-zA-Z]+\z/

  validates :name, :surname, :patronymic, :email, :role, presence: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :name, length: { maximum: 30 }
  validates :email, uniqueness: true, email: true
  validates :surname, :patronymic, format: { with: LETTER_REGEX }
  enumerize :role, in: %i[admin editor], default: :admin

  has_secure_password validations: false

  state_machine initial: :active do
    state :active
    state :deleted

    event :del do
      transition from: :active, to: :deleted, if: :active?
    end

    event :activate do
      transition from: :deleted, to: :active, if: :deleted?
    end
  end
end
