class AdminMailer < Spree::BaseMailer

  default from: 'no_reply@ultimate-cycle-distribution.com'

  def warn_for_new_user(user)
    @user = user
    admin_emails = Spree::User.admin.pluck(:email)
    mail(to: admin_emails, subject: "Un nouvel utilisateur viens de s'inscrire")
  end

  def warn_for_new_contact(contact)
    @contact = contact
    admin_emails = Spree::User.admin.pluck(:email)
    mail(to: admin_emails, subject: 'Un nouveau contact à été enregistré')
  end
end
