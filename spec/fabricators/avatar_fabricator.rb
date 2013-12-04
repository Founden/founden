Fabricator(:avatar) do
  user
  attachment { File.open(Rails.root.join('spec/fixtures/test.png')) }
end
