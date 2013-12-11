# Attachment class serializer
class AttachmentSerializer < ActiveModel::Serializer
  attributes :id, :title, :type

  has_one :user, :embed_key => :slug
  has_one :network, :embed_key => :slug, :embed_in_root => false
  has_one :conversation, :embed_key => :slug, :embed_in_root => false
  has_one :message, :embed_key => :slug, :embed_in_root => false

  # Mask the id with the slug value
  def id
    object.slug
  end

  # Camelizes the attachment type
  def type
    object.type.to_s.camelize(:lower)
  end
end
