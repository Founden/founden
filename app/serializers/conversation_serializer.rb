# Conversation class serializer
class ConversationSerializer < ActiveModel::Serializer
  root :conversation

  attributes :id, :title

  has_one :user, :embed_key => :slug
  has_one :network, :embed_key => :slug, :embed_in_root => false
  has_many :messages, :embed_key => :slug

  # Mask the id with the slug value
  def id
    object.slug
  end
end
