# Network class serializer
class NetworkSerializer < ActiveModel::Serializer
  root :network

  attributes :id, :title

  has_many :conversations

  # Mask the id with the slug value
  def id
    object.slug
  end
end
