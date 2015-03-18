class ExportJob < ActiveJob::Base
  queue_as do
    export = self.arguments.first
    "#{export.source}-exports"
  end

  def perform(export, completed_gt = nil, completed_lt = nil)
    data = export.load_data(completed_gt, completed_lt)
    AdminMailer.export(export.source, data).deliver_now
  end

  after_perform do |job|
    job.arguments.first.update_attributes!(status: :available)
  end
end
