module Spree
  module Admin
    class ExportsController < Spree::Admin::ResourceController

      before_action :set_lastest_exports, only: :index
      before_action :check_exports_in_progress, only: :index

      def index
        @export_new = Export.new
      end

      def create

        export = Export.create!(export_params)

        data = export.load_data(params[:start], params[:end])
        export.send_export(data)


        redirect_to admin_exports_path, notice: Spree.t('exports.export_created')
      end

      private

        def export_params
          params.require(:export).permit(:source)
        end

        def set_lastest_exports
          @last_exports = Export.get_last_available_date_per_source
        end

        def check_exports_in_progress
          @exports_in_progress = Export.check_has_in_progress_per_source
        end
    end
  end
end
