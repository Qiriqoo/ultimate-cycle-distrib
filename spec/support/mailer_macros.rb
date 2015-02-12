module MailerMacros

  def deliveries_with_subject(subject)
    ActionMailer::Base.deliveries.select do |email|
      email.subject == subject
    end
  end

end
