# Message location attachment class
class Location < Attachment
  # Store geolocation with hstore
  store_accessor :data, :latitude, :longitude
end
