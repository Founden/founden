# User class serializer
class UserSerializer < ActiveModel::Serializer
  include AvatarHelper

  root :user

  attributes :id, :first_name, :last_name
  attributes :avatar_url, :contact_ids

  has_many :conversations, :embed_key => :slug
  has_many :summaries, :embed_key => :slug
  has_many :created_friendships, :embed_key => :slug, :embed_in_root => false
  has_many :friendships, :embed_key => :slug, :embed_in_root => false

  # Mask the id with the slug value
  def id
    object.slug
  end

  # Returns user avatar URL
  def avatar_url
    avatar_uri(object)
  end

  # User contacts
  # TODO: Delegate a separate endpoint to avoid pre-loading huge data set
  def contact_ids
    (object.added_contacts + object.mutual_contacts).map{|ct| ct.slug }
  end

  # Filters out some keys from other users
  def filter(keys)
    if !scope.id.eql?(object.id)
      keys - %i{conversations summaries contact_ids} -
       %i{created_friendships friendships}
    else
      keys
    end
  end
end
