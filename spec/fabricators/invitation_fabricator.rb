Fabricator(:invitation) do
  email      { Faker::Internet.email }
  user
  network { |attrs| Fabricate(:network, :user => attrs[:user]) }
end
