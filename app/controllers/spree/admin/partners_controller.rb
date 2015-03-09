module Spree
  module Admin
    class PartnersController < Spree::Admin::ResourceController

      before_action :load_partner, only: [:edit, :update, :destroy]

      def index
        @partners = Partner.order('created_at DESC')
      end

      def new
        @partner = Partner.new(status: params[:status].to_i || 0)
      end

      def edit
      end

      def create
        partner = Partner.new(partner_params)

        if partner.save
          redirect_to admin_partners_path, notice: Spree.t('pages.partner.added')
        else
          redirect_to new_admin_partner_path, alert: partner.errors.first.join(' ')
        end
      end

      def update
        if @partner.update(partner_params)
          redirect_to admin_partners_path, notice: Spree.t('pages.partner.edited')
        else
          redirect_to edit_admin_partner_path(@partner.id), alert: @partner.errors.first.join(' ')
        end
      end

      def destroy
        if @partner.destroy
          redirect_to admin_partners_path, notice: Spree.t('pages.partner.deleted')
        else
          redirect_to admin_partners_path, alert: @partner.errors.first.join(' ')
        end
      end

      private
        def partner_params
          params.require(:partner).permit(:name, :logo, :status, :description)
        end

        def load_partner
          @partner = Partner.find(params[:id])
        end

    end
  end
end
