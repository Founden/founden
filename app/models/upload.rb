# Message upload attachment class
class Upload < Attachment
  # Relationships
  has_attached_file :attachment

  # Validations
  validates_attachment_presence :attachment
end
