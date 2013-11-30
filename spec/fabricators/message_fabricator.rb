Fabricator(:message) do
  content      { Faker::Lorem.paragraph }
  user
  network
  conversation
end
