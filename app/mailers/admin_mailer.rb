class AdminMailer < Spree::BaseMailer

  default to: Proc.new { Spree::User.admin.pluck(:email) },
          from: 'no_reply@ultimate-cycle-distribution.com'

  def warn_for_new_user(user)
    @user = user
    mail(subject: "Un nouvel utilisateur viens de s'inscrire")
  end

  def warn_for_new_contact(contact)
    @contact = contact
    mail(subject: 'Un nouveau contact à été enregistré')
  end

  def warn_for_empty_stock(stock_item)
    @stock_item = stock_item
    mail(subject: "Le stock de produit pour #{stock_item.variant_name} est désormais vide")
  end
end
