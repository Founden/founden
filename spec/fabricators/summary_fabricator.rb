Fabricator(:summary) do
  transient    :user
  conversation { |attrs|
    Fabricate(:conversation, :user => attrs[:user] || Fabricate(:user)) }
end
