# User avatar attachment class
class Avatar < Attachment
  # List of allowed mime-types for image uploads
  IMAGE_TYPES = %w( image/jpeg image/png image/gif image/pjpeg image/x-png )

  # Attachment overwrite
  has_attached_file :attachment, :styles => Founden::Config.image.sizes

  # Validations
  validates_presence_of :user, :attachment
  validates_attachment_content_type :attachment, :content_type => IMAGE_TYPES
end
