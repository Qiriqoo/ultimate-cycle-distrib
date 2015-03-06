module Spree
  module Admin
    class ExportsController < Spree::Admin::ResourceController

      def index
        @export_newsletters_new = Export.new
        @export_in_progress = Export.in_progress.where(source: 'newsletters').first
        @last_newsletters_export = Export.available.where(source: 'newsletters')
                              .order('created_at DESC')
                              .pluck(:created_at)
                              .first
      end

      def create
        export = Export.create!(export_params)
        data = export.load_data
        export.send_export(data)

        redirect_to admin_exports_path, notice: Spree.t('newsletter.export_created')
      end

      private

        def export_params
          params.require(:export).permit(:source)
        end
    end
  end
end
