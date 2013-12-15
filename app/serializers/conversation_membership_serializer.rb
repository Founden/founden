# Conversation membership class serializer
class ConversationMembershipSerializer < MembershipSerializer
  root :membership

  has_one :conversation, :embed_key => :slug, :embed_in_root => false
end
