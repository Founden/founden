# Summary class serializer
class SummarySerializer < ActiveModel::Serializer
  root :summary

  attributes :id, :created_at

  has_one :conversation, :embed_key => :slug, :embed_in_root => false
  has_many :messages, :embed_key => :slug

  # Mask the id with the slug value
  def id
    object.slug
  end
end
