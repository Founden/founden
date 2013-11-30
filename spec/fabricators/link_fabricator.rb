Fabricator(:link, :class_name => Link, :from => :attachment) do
  url { Faker::Internet.uri(Link::ALLOWED_SCHEMES.sample) }
end
