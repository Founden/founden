# Conversation membership class
class ConversationMembership < Membership
  # Validations
  validates_presence_of :network
  validates_presence_of :conversation
  validates_inclusion_of :network_id, :in => :conversation_network_ids
  validates_inclusion_of :conversation_id, :in => :creator_conversation_ids
  validates_inclusion_of :creator_id, :in => :conversation_participant_ids

  private

  # Membership creator allowed conversation IDs
  def creator_conversation_ids
    self.creator ?
      self.creator.conversation_ids + self.creator.created_conversation_ids : []
  end

  # Membership conversation allowed network IDs
  def conversation_network_ids
    self.conversation ? [self.conversation.network_id] : []
  end

  # Membership conversations allowed participant IDs
  def conversation_participant_ids
    self.conversation ?
      self.conversation.participant_ids + [self.conversation.user_id] : []
  end

end
