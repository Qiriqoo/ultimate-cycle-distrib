module StockItemExtension

  def self.included klass

    klass.include InstanceMethods

    klass.after_update :warn_admin, if: [:count_on_hand_changed?, :stock_empty?]
  end

  module InstanceMethods

    def stock_empty?
      self.count_on_hand.zero?
    end

    def warn_admin
      AdminMailer.delay.warn_for_empty_stock(self)
    end

  end
end

Spree::StockItem.include(StockItemExtension)
