module OrderExtension

  def self.included klass

    klass.extend ClassMethods
    klass.include InstanceMethods
  end

  module ClassMethods

    def export_columns
      [:number, :items_name, :item_count, :item_total, :adjustment_total, :total, :promo_total,
       :shipping_method_name, :shipment_total, :payment_total, :email, :bill_address_name,
       :bill_address_location, :ship_address_name, :ship_address_location]
    end

    def export_column_names
      names = []
      export_columns.each do |column|
        names.push(Spree.t("orders_export_column_names.#{column}"))
      end
      names
    end

  end

  module InstanceMethods

    [:bill, :ship].each do |method|
      resource_name = "#{method}_address"

      define_method("#{method}_address_name") do
        send(resource_name).full_name
      end

      define_method("#{method}_address_location") do
        send(resource_name).full_location
      end
    end

    def items_name
      line_items.map(&:product).map(&:name).join(', ')
    end

    def shipping_method_name
      try(:shipping_method).try(:name)
    end

    def export_column_values
      values = []
      Spree::Order.export_columns.each do |column|
        value = send(column)
        values.push(value.kind_of?(BigDecimal) ? "#{value.to_money.to_s} €" : value)
      end
      values
    end

    def weight_total
      variants.pluck(:weight).sum
    end

  end
end

Spree::Order.include(OrderExtension)
