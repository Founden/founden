Fabricator(:google_identity, :class_name => Identity) do
  uid       { sequence(:uid_email) { |eid| [Faker::Internet.email] } }
  token     { 'DUMMY_TOKEN' }
end
