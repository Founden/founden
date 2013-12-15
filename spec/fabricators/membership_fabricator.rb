Fabricator(:membership) do
  creator(:fabricator => :user)
  user
end
