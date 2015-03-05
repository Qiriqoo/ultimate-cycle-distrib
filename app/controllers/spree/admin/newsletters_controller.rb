module Spree
  module Admin
    class NewslettersController < Spree::Admin::ResourceController

      def index
        @search = Newsletter.search(params[:q])
        @newsletter = Newsletter.new
        @last_export = Export.available.where(source: 'newsletters')
                              .order('created_at DESC')
                              .pluck(:created_at)
                              .first

        if params[:q].present?
          @newsletters = Newsletter.ransack(params[:q]).result.page(params[:page])
        else
          @newsletters = Newsletter.all.page(params[:page])
        end
      end

      def create
        newsletter = Newsletter.new(newsletter_params)

        if newsletter.save
          redirect_to admin_newsletters_path, notice: Spree.t('newsletter.added')
        else
          redirect_to admin_newsletters_path, alert: newsletter.errors.first.join(' ')
        end
      end

      def destroy
        newsletter = Newsletter.find(params[:id])

        if newsletter.destroy
          redirect_to admin_newsletters_path, notice: Spree.t('newsletter.deleted')
        else
          redirect_to admin_newsletters_path, alert: newsletter.errors.first.join(' ')
        end
      end

      def export

        Export.create!(source: 'newsletters')

        redirect_to admin_newsletters_path, notice: Spree.t('newsletter.export_created')
      end

      private
        def newsletter_params
          params.require(:newsletter).permit(:email)
        end
    end
  end
end
