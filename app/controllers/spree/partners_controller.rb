module Spree
  class PartnersController < Spree::StoreController

    def index
      @partners = Partner.order('created_at DESC')
    end

  end
end
