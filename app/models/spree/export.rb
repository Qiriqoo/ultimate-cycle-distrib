class Spree::Export < ActiveRecord::Base

  enum source: [:newsletters, :orders]

  enum status: [:in_progress, :available, :failed]

  def launch_export(completed_gt = nil, completed_lt = nil)
    ExportJob.perform_later(self, completed_gt, completed_lt)
  end

  def load_data(completed_gt = nil, completed_lt = nil)
    case source
    when 'newsletters'
      Spree::Newsletter.pluck(:email)
    when 'orders'
      completed_gt = Spree::Order.complete.minimum(:created_at) if completed_gt.blank?
      completed_lt = Spree::Order.complete.maximum(:created_at) if completed_lt.blank?
      Spree::Order.completed_between(completed_gt, completed_lt)
    end
  end

  def self.get_last_available_date_per_source
    exports = {}
    Spree::Export.sources.keys.each do |source|
      exports[source.to_sym] = Spree::Export.send(source).available.maximum(:created_at)
    end
    exports
  end

  def self.check_has_in_progress_per_source
    exports = {}
    Spree::Export.sources.keys.each do |source|
      exports[source.to_sym] = Spree::Export.send(source).in_progress.any?
    end
    exports
  end


end
