class User < ApplicationRecord
  validates_presence_of :first_name, :last_name
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  has_secure_password
end
