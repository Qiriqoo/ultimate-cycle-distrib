module Spree
  class NewslettersController <  Spree::Admin::ResourceController

    def create
      newsletter = Newsletter.new(newsletter_params)

      if newsletter.save
        redirect_to :back, notice: Spree.t('newsletter.added')
      else
        redirect_to :back, alert: newsletter.errors.first.join(' ')
      end
    end

    private
      def newsletter_params
        params.require(:newsletter).permit(:email)
      end
  end
end
