class Customer < ApplicationRecord
  belongs_to :user

  validates :last_name, :email, presence: true

   scope :sent, -> { where(mail_sent: true) }
   scope :notsent, -> { where(mail_sent: false) }

end
