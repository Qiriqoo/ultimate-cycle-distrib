class AdminMailer < Spree::BaseMailer
  layout 'mailer'

  default to: Proc.new { Spree::User.admin.pluck(:email) },
          from: Proc.new { Spree::Store.last.mail_from_address }


  before_action :set_logo


  def warn_for_new_user(user)
    @user = user
    role = user.has_spree_role?('admin') ? 'admin' : 'user'
    @subject = I18n.t("admin_mailer.warn_for_new_#{role}")

    mail(subject: @subject)
  end

  def warn_for_new_contact(contact)
    @contact = contact
    @subject = I18n.t("admin_mailer.warn_for_new_contact")

    mail(subject: @subject)
  end

  def warn_for_empty_stock(stock_item)
    @stock_item = stock_item
    @subject = I18n.t("admin_mailer.warn_for_empty_stock", name: stock_item.variant_name)

    mail(subject: @subject)
  end

  def export(source, resources)
    @resources = resources
    @subject = I18n.t("admin_mailer.export", source: source.capitalize, date: Date.today.to_s)

    xlsx = render_to_string(handlers: [:axlsx], formats: [:xlsx], template: "exports/#{source}", layout: false)
    attachments["#{source}-#{Date.today.to_s}.xlsx"] = {mime_type: Mime::XLSX, content: xlsx}

    mail(subject: @subject)
  end

  private
    def set_logo
      attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logo/logo.png'))
    end
end
