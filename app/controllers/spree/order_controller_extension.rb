 module OrdersControllerExtension

  def self.included klass
    klass.include ClassMethods
    klass.alias_method_chain :show, :orders_controller_extension
  end

  module ClassMethods

    def show_with_orders_controller_extension
      @order = Spree::Order.find_by_number!(params[:id])

      respond_to do |format|
        format.html
        format.pdf
      end
    end

  end
end

Spree::OrdersController.include(OrdersControllerExtension)
