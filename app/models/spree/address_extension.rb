module AddressExtension

  def self.included klass

    klass.include InstanceMethods
  end

  module InstanceMethods

    def country_name
      country.name
    end

    def full_name
      [firstname, lastname].join(' ')
    end

    def full_location
      [address1, address2, city, zipcode, state_text, country_name].join(', ')
    end

  end
end

Spree::Address.include(AddressExtension)
