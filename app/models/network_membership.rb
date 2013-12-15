# Network membership class
class NetworkMembership < Membership
  # Validations
  validates_presence_of :network
  validates_inclusion_of :network_id, :in => :creator_created_network_ids

  private

  # Membership creator network IDs
  def creator_created_network_ids
    self.creator ? self.creator.created_network_ids : []
  end
end
