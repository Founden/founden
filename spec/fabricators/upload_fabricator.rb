Fabricator(:upload, :class_name => Upload, :from => :attachment) do
  attachment { File.open(Rails.root.join('spec/fixtures/test.png')) }
end

Fabricator(:raw_upload, :from => :upload) do
  attachment { Rack::Test::UploadedFile.new(
    Rails.root.join('spec/fixtures/test.png'), 'image/png') }
end
