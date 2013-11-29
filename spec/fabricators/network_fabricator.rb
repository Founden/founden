Fabricator(:network) do
  title { sequence(:title) { Faker::Company.name } }
  user  { Fabricate(:user) }
end
