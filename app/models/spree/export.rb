class Spree::Export < ActiveRecord::Base

  enum status: [:in_progress, :available, :failed]

  def send_export(resources)
    AdminMailer.export(self.source, resources).deliver
    self.update_attributes!(status: :available)
  end
  handle_asynchronously :send_export, queue: ->(export) { "#{export.source}-exports" }

end
