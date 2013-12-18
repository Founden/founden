# Invitation class serializer
class InvitationSerializer < ActiveModel::Serializer
  root :invitation

  attributes :id, :email, :created_at
  attributes :network_title

  has_one :user, :embed_key => :slug, :embed_in_root => false
  has_one :network, :embed_key => :slug
  has_one :membership, :embed_key => :slug

  # Mask the id with the slug value
  def id
    object.slug
  end

  # Serializes network title
  def network_title
    object.network.title
  end

  # Filters out some keys from other users
  def filter(keys)
    if !scope.eql?(object.user) and !object.network.contacts.include?(scope)
      keys.delete(:email)
      keys.delete(:network)
    end
    keys
  end
end
