# Location class serializer
class LocationSerializer < AttachmentSerializer
  root :location

  attributes :latitude, :longitude
end
