class Customer < ApplicationRecord
  belongs_to :user

  validates :last_name, :email, presence: true
end
