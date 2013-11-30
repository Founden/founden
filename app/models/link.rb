require 'uri'

# Message link attachment class
class Link < Attachment
  # List of allowed URI schemes
  ALLOWED_SCHEMES = %w(http https)

  # Store geolocation with hstore
  store_accessor :data, :url

  # Validations
  validates_format_of :url, :with => URI.regexp(ALLOWED_SCHEMES)
  validates_presence_of :url
end
