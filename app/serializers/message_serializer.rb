# Message class serializer
class MessageSerializer < ActiveModel::Serializer
  root :message

  attributes :id, :content, :attachments, :created_at

  has_one :user, :embed_key => :slug
  has_one :network, :embed_key => :slug
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

  # Since `polymorphic` is not available yet, lets use it through attributes
  def attachments
    object.attachments.map do |attachment|
      { :id => attachment.slug, :type => attachment.type.to_s.underscore }
    end
  end
end
