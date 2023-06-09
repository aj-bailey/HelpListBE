class User < ApplicationRecord
  has_many :organization_users
  has_many :organizations, through: :organization_users
  has_many :wishlist_items
  has_many :user_wishlist_items

  enum user_type: ["donor", "recipient"]

  validates :email, uniqueness: true,
                    presence: true,
                    format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates_presence_of :password

  has_secure_password
end
