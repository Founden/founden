Fabricator(:conversation) do
  title   { sequence(:title) { Faker::Lorem.sentence } }
  user
end
