module Spree
  module Admin
    class ContactsController < Spree::Admin::ResourceController

      def index
        @search = Contact.search(params[:q])

        if params[:q].present?
          @contacts = Contact.ransack(params[:q]).result.page(params[:page])
        else
          @contacts = Contact.all.order('created_at DESC').page(params[:page])
        end
      end

      def show
        @contact = Contact.find(params[:id])
        @contact.update_attributes!(read: true) unless @contact.read
      end
    end
  end
end
