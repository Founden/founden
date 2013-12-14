# Upload class serializer
class UploadSerializer < AvatarSerializer
  root :upload

  attributes :attachment_file_size, :attachment_file_name

  # Overwrite method inherited from avatar serializer
  def filter(keys)
    keys
  end
end
