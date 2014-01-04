# Friendship class
class Friendship < Membership
  # Validations
  validates_presence_of :creator, :user
  validates_exclusion_of :user_id, :in => :creator_contact_ids

  private

  # Membership creator existing contact IDs
  def creator_contact_ids
    self.creator ? self.creator.added_contact_ids + [self.creator_id] : []
  end

end
