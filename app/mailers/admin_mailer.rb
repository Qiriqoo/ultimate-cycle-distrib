class AdminMailer < Spree::BaseMailer
  layout 'mailer'

  default to: Proc.new { Spree::User.admin.pluck(:email) },
          from: 'no_reply@ultimate-cycle-distribution.com'


  before_action :set_logo


  def warn_for_new_user(user)
    @user = user
    @subject = "Un nouvel utilisateur viens de s'inscrire"

    mail(subject: @subject)
  end

  def warn_for_new_contact(contact)
    @contact = contact
    @subject = 'Un nouveau contact à été enregistré'

    mail(subject: @subject)
  end

  def warn_for_empty_stock(stock_item)
    @stock_item = stock_item
    @subject = "Le stock de produit pour #{stock_item.variant_name} est désormais vide"

    mail(subject: @subject)
  end

  def export(source, resources)
    @resources = resources
    @subject = "Export de vos #{source.capitalize} - #{Date.today.to_s}"

    xlsx = render_to_string(handlers: [:axlsx], formats: [:xlsx], template: "exports/#{source}", layout: false)
    attachments["#{source}-#{Date.today.to_s}.xlsx"] = {mime_type: Mime::XLSX, content: xlsx}

    mail(subject: @subject)
  end

  private
    def set_logo
      attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logo/logo.png'))
    end
end
