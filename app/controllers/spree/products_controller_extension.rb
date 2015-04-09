module ProductsControllerExtension

  def self.included klass

    klass.include InstanceMethods

    klass.alias_method_chain :show, :products_controller_extension
  end

  module InstanceMethods

    def show_with_products_controller_extension
      @variants = @product.variants_including_master.active(current_currency).includes([:option_values, :images])
      @product_properties = @product.product_properties.includes(:property)
      @taxon = Spree::Taxon.find(params[:taxon_id]) if params[:taxon_id]
      @cross_products = @product.get_cross_products
    end

  end
end

Spree::ProductsController.include(ProductsControllerExtension)
