module Spree
  class PagesController < Spree::StoreController

    def show
      @page = Page.find_by(slug: params[:id])
    end

  end
end
