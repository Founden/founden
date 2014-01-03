Fabricator(:message) do
  content      { Faker::Lorem.paragraph }
  user
  conversation { |attrs| Fabricate(:conversation, :user => attrs[:user]) }
end
