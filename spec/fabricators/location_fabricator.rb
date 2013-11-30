Fabricator(:location, :class_name => Location, :from => :attachment) do
  latitude  { Faker::Geolocation.lat.to_f.round(5) }
  longitude { Faker::Geolocation.lng.to_f.round(5) }
end
