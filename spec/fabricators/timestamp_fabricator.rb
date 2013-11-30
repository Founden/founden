Fabricator(:timestamp, :class_name => Timestamp, :from => :attachment) do
  timestamp { DateTime.current.to_s }
end
