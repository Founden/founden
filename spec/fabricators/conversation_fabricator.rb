Fabricator(:conversation) do
  title   { sequence(:title) { Faker::Lorem.sentence } }
  user
  network { |attrs| Fabricate(:network, :user => attrs[:user]) }
end
