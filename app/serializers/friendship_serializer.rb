# Friendship class serializer
class FriendshipSerializer < MembershipSerializer
  root :membership

  has_one :user, :embed_key => :slug, :embed_in_root => false
end
