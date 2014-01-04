# Conversation class serializer
class ConversationSerializer < ActiveModel::Serializer
  root :conversation

  attributes :id, :title, :created_at

  has_one :user, :embed_key => :slug
  has_one :summary, :embed_key => :slug
  has_many :messages, :embed_key => :slug
  has_many :participants, :embed_key => :slug, :embed_in_root => false

  # Mask the id with the slug value
  def id
    object.slug
  end
end
