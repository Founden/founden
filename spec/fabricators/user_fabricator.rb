Fabricator(:user) do
  first_name { sequence(:name) { |nid| Faker::Name.first_name.delete("'") } }
  last_name  { sequence(:name) { |nid| Faker::Name.last_name.delete("'") } }
  email      { sequence(:email) { |eid| Faker::Internet.email } }

  identities(:count => 1) { |attrs, i|
    Fabricate(:google_identity, :uid => [attrs[:email]]) }
end
