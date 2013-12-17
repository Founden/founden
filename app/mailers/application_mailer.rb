# Default application mailer
class ApplicationMailer < ActionMailer::Base
  default :from => Founden::Config.default_email,
    :return_path => Founden::Config.contact_email

  # Because `Mailer#method().deliver!` syntax is hard to handle
  def self.deliver(method, *args)
    send(method, *args).deliver!
  end
end
