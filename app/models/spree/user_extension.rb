module UserExtension

  def self.included klass

    klass.include InstanceMethods

    klass.before_create :set_active, if: :is_admin?

    klass.after_create :warn_admin, unless: :is_admin?
  end

  module InstanceMethods

    def set_active
      self.active = true
    end

    def is_admin?
      self.spree_roles.map(&:name).include?('admin')
    end

    def warn_admin
      AdminMailer.warn_for_new_user(self).deliver
    end

  end
end

Spree::User.include(UserExtension)
