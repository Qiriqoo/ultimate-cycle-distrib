module Spree
  module Admin
    class PagesController < Spree::Admin::ResourceController

      def index
        redirect_to admin_page_path(Page.find_by(slug: 'conditions-generales-de-ventes').id)
      end

      def show
        @page = Page.find(params[:id])
      end

      def update
        page = Page.find(params[:id])
        if page.update(page_params)
          redirect_to admin_page_path(page.id), notice: Spree.t('pages.updated')
        else
          redirect_to admin_page_path(page.id), alert: page.errors.first.join(' ')
        end
      end

      private

        def page_params
          params.require(:page).permit(:content)
        end
    end
  end
end
