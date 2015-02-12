class UserMailer < Spree::BaseMailer

  default from: 'no_reply@ultimate-cycle-distribution.com'

  def warn_administrators_for_new_user(user)
    @user = user
    admin_emails = Spree::User.admin.pluck(:email)
    mail(to: admin_emails, subject: "Un nouvel utilisateur viens de s'inscrire")
  end
end
