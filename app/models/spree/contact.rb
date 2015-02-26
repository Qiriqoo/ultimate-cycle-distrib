class Spree::Contact < ActiveRecord::Base

  validates :email,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
    presence: true

  validates :subject, presence: true
  validates :content, presence: true

  after_create :warn_admin

  def warn_admin
    AdminMailer.warn_for_new_contact(self).deliver
  end

end
