# Message class serializer to be sent as an update
# The purpose of this serializer is to include as much
# data as possible
class UpdateSerializer < ActiveModel::Serializer
  root :message

  attributes :id, :content, :attachments, :created_at, :is_unread

  has_one :user, :embed_key => :slug
  has_one :conversation, :embed_key => :slug
  has_one :parent_message, :embed_key => :slug
  has_one :summary, :embed_key => :slug
  has_many :replies, :embed_key => :slug
  # See below...
  # has_many :attachments, :embed_key => :slug

  # Mask the id with the slug value
  def id
    object.slug
  end

  # Mark this as unread
  def is_unread
    true
  end

  # Get the original content through a Markdown parser
  def content
    Founden::Application.config.markdown.render(object.content)
  end

  # Since `polymorphic` is not available yet, lets use it through attributes
  def attachments
    object.attachments.map do |attachment|
      { :id => attachment.slug, :type => attachment.type.to_s.underscore }
    end
  end
end
