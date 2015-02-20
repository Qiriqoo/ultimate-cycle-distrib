module Spree
  class ContactsController < Spree::StoreController

    def new
      @contact = Contact.new
    end

    def create
      @contact = Contact.new(contact_params)

      if @contact.save
        redirect_to :back, notice: Spree.t('pages.contact.added')
      else
        redirect_to :back, alert: @contact.errors.first.join(' ')
      end
    end

    private
      def contact_params
        params.require(:contact).permit(:email, :subject, :content)
      end
  end
end
