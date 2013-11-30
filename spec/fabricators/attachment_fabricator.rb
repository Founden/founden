Fabricator(:attachment) do
  title        { Faker::Lorem.sentence }
  user
  network
  conversation
  message
end
