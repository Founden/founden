Fabricator(:summary) do
  transient    :user
  network      { |attrs| Fabricate(:network, :user => attrs[:user]) }
  conversation { |attrs| Fabricate(
    :conversation, :user => attrs[:user], :network => attrs[:network]) }
end
