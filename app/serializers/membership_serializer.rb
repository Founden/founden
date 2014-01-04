# Membership class serializer
class MembershipSerializer < ActiveModel::Serializer
  root :membership

  attributes :id, :created_at

  has_one :creator, :embed_key => :slug, :embed_in_root => false
  has_one :user, :embed_key => :slug

  # Mask the id with the slug value
  def id
    object.slug
  end
end
