# Network class serializer
class NetworkSerializer < ActiveModel::Serializer
  root :network

  attributes :id, :title

  has_one :user, :embed_key => :slug, :embed_in_root => false
  has_many :conversations, :embed_key => :slug

  # Mask the id with the slug value
  def id
    object.slug
  end
end
