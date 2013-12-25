# Support for notifications
module Notifier
  # Support for concerns
  extend ActiveSupport::Concern

  included do
    after_create :notify_channels
  end

  private

  # Generates a payload to be sent on notify
  # @return String comma delimited values of form `Class, ID`
  def payload
    self.class.connection.quote([self.class.name, self.id].join(','))
  end

  # Callback to notify one of the channels
  def notify_channels
    notification_channels.each do |channel|
      self.class.connection.execute('NOTIFY %s, %s' % [channel, payload])
    end
  end

  # Returns a list of channels to be notified
  # @return Should return an array with string values of form `['user_ID']`
  def notification_channels
    []
  end
end
