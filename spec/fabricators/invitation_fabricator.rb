Fabricator(:invitation) do
  email      { Faker::Internet.email }
  user
end
