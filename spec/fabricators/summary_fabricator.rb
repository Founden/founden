Fabricator(:summary) do
  transient    :user
  network      { |attrs| Fabricate(
    :network, :user => attrs[:user] || Fabricate(:user)) }
  conversation { |attrs| Fabricate(
    :conversation, :user => attrs[:network].user, :network => attrs[:network]) }
end
