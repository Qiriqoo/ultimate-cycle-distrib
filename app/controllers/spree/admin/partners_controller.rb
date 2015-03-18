module Spree
  module Admin
    class PartnersController < Spree::Admin::ResourceController

      def new
        @partner = Partner.new(status: params[:status].to_i || 0)
      end

      private
        def partner_params
          params.require(:partner).permit(:name, :logo, :status, :description)
        end

    end
  end
end
