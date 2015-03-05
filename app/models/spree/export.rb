class Spree::Export < ActiveRecord::Base

  enum status: [:in_progress, :available, :failed]

  after_create :send_export

  def send_export
    AdminMailer.export(source).deliver
    self.update_attributes!(status: :available)
  end
  handle_asynchronously :send_export, queue: ->(export) { "#{export.source}-exports" }

end
