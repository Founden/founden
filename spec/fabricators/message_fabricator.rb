Fabricator(:message) do
  content      { Faker::Lorem.paragraph }
  user
  network      { |attrs| Fabricate(:network, :user => attrs[:user]) }
  conversation { |attrs| Fabricate(
    :conversation, :user => attrs[:user], :network => attrs[:network]) }
end
