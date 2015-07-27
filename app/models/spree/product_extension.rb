module ProductExtension

  def self.included klass

    klass.include InstanceMethods
  end

  module InstanceMethods

    def get_cross_products
      return Spree::Product.order('RANDOM()').limit(3).distinct if taxons.blank?

      Spree::Product.joins(:taxons)
                    .where('spree_taxons.id IN (?)', taxons.pluck(:id))
                    .where('spree_products.id != ?', id)
                    .limit(3)
                    .distinct
    end
  end
end

Spree::Product.include(ProductExtension)
