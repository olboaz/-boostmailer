require 'csv'
class Customer < ApplicationRecord
  belongs_to :user

  scope :sent, -> { where(mail_sent: true) }
  scope :notsent, -> { where(mail_sent: false) }

  validates :restaurant_name, :email, presence: true
  validates :restaurant_name, uniqueness: { message: "Le client existe déjà !" }


end
