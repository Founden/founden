# Invitation class serializer
class InvitationSerializer < ActiveModel::Serializer
  root :invitation

  attributes :id, :email, :created_at

  has_one :user, :embed_key => :slug, :embed_in_root => false
  has_one :network, :embed_key => :slug, :embed_in_root => false
  has_one :membership, :embed_key => :slug

  # Mask the id with the slug value
  def id
    object.slug
  end
end
