# Conversation class serializer
class ConversationSerializer < ActiveModel::Serializer
  root :conversation

  attributes :id, :title

  has_many :messages

  # Mask the id with the slug value
  def id
    object.slug
  end
end
