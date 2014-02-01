# Message upload attachment class
class Upload < Attachment
  # Relationships
  has_attached_file :attachment, :styles => Founden::Config.image.sizes

  # Validations
  validates_presence_of :user, :message

  # Validations
  validates_attachment_presence :attachment
  do_not_validate_attachment_file_type :attachment
end
