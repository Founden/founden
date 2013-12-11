# Upload class serializer
class UploadSerializer < AvatarSerializer
  root :upload

  # Overwrite method inherited from avatar serializer
  def filter(keys)
    keys
  end
end
