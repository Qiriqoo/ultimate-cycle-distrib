module UserExtension

  def self.included klass

    klass.include InstanceMethods

    klass.after_create :warn_admin
    klass.after_create :generate_spree_api_key!
  end

  module InstanceMethods

    def warn_admin
      AdminMailer.warn_for_new_user(self).deliver_later
    end

  end
end

Spree::User.include(UserExtension)
