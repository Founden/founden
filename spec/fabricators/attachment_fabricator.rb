Fabricator(:attachment) do
  title        { Faker::Lorem.sentence }
  user
  conversation { |attrs| Fabricate(:conversation, :user => attrs[:user]) }
  message      { |attrs| Fabricate(
    :message, :user => attrs[:user], :conversation => attrs[:conversation]) }
end
