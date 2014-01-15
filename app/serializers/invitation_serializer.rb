# Invitation class serializer
class InvitationSerializer < ActiveModel::Serializer
  root :invitation

  attributes :id, :email, :created_at

  has_one :user, :embed_key => :slug, :embed_in_root => false
  has_one :membership, :embed_key => :slug, :embed_in_root => false

  # Mask the id with the slug value
  def id
    object.slug
  end

  # Filters out some keys from other users
  def filter(keys)
    if !scope.eql?(object.user) and (
      object.membership and !object.membership.user.eql?(scope))
      keys.delete(:email)
    end
    keys
  end
end
