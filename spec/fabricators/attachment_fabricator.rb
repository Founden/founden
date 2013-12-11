Fabricator(:attachment) do
  title        { Faker::Lorem.sentence }
  user
  network      { |attrs| Fabricate(:network, :user => attrs[:user]) }
  conversation { |attrs| Fabricate(
    :conversation, :user => attrs[:user], :network => attrs[:network]) }
  message      { |attrs| Fabricate(
    :message, :user => attrs[:user], :network => attrs[:network],
    :conversation => attrs[:conversation]) }
end
