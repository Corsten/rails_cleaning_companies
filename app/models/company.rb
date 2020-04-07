class Company < ApplicationRecord
  validates :name, :email, :password_digest, :requisites, :description,
  :rating, :website, :phone_number, presence: true
  validates :name, length: { maximum: 30 }
  validates :email, uniqueness: true, email: true
  validates :phone_number, phone: true
end