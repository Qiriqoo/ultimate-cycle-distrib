module Spree
  module Admin
    class NewslettersController < Spree::Admin::ResourceController

      before_action :set_newsletters_count, only: :new

      def index
        @search = Newsletter.search(params[:q])
        @newsletter = Newsletter.new

        if params[:q].present?
          @newsletters = Newsletter.ransack(params[:q]).result.page(params[:page])
        else
          @newsletters = Newsletter.all.page(params[:page])
        end
      end

      private
        def newsletter_params
          params.require(:newsletter).permit(:email)
        end

        def set_newsletters_count
          @newsletters = Newsletter.count
        end
    end
  end
end
