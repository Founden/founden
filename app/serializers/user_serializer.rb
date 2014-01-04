# User class serializer
class UserSerializer < ActiveModel::Serializer
  include AvatarHelper

  root :user

  attributes :id, :first_name, :last_name
  attributes :avatar_url, :contact_ids

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
    keys.delete(:contact_ids) if !scope.id.eql?(object.id)
    keys
  end
end
