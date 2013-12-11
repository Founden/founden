# Avatar class serializer
class AvatarSerializer < AttachmentSerializer
  root :avatar

  attributes :attachment, :thumb_size_url, :small_size_url, :medium_size_url

  # Thumb size of the attachment
  def thumb_size_url
    object.attachment.url(:thumb)
  end

  # Small size of the attachment
  def small_size_url
    object.attachment.url(:small)
  end

  # Medium size of the attachment
  def medium_size_url
    object.attachment.url(:medium)
  end

  # Filter unused relationships inherited from attachment serialzier
  def filter(keys)
    keys - [:network, :conversation, :message]
  end
end
