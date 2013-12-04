# User class serializer
class UserSerializer < ActiveModel::Serializer
  include AvatarHelper

  root :user

  attributes :id, :first_name, :last_name
  attributes :avatar_url

  has_many :networks

  # Mask the id with the slug value
  def id
    object.slug
  end

  # Returns user avatar URL
  def avatar_url
    avatar_uri(object)
  end

  # Filters out some keys from other users
  def filter(keys)
    keys.delete(:networks) if !scope.id.eql?(object.id)
    keys
  end
end
