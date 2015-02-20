module Spree
  module Admin
    class PagesController < Spree::Admin::ResourceController

      def index
        redirect_to admin_page_path(Page.find_by(slug: 'conditions-generales-de-ventes').id)
      end

      def show
        @page = Page.find(params[:id])
      end
    end
  end
end
