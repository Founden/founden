# Message location attachment class
class Location < Attachment
  # Store geolocation with hstore
  store_accessor :data, :latitude, :longitude

  # Validations
  validates_presence_of :user, :message, :latitude, :longitude
end
