# Message class serializer
class MessageSerializer < ActiveModel::Serializer
  root :message

  attributes :id, :content

  has_one :user, :embed_key => :slug
  has_one :network, :embed_key => :slug, :embed_in_root => false
  has_one :conversation, :embed_key => :slug, :embed_in_root => false

  # Mask the id with the slug value
  def id
    object.slug
  end
end
