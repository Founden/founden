require 'digest/sha1'

# Adds additional logic to help `FriendlyId` generate SHA1 slugs
module ObfuscatedId
  extend ActiveSupport::Concern

  included do
    extend FriendlyId

    # Obfuscates record ID
    friendly_id :obfuscated_ids, :use => :slugged
  end

  # Generates a list of hashes to be used as the ID
  def obfuscated_ids
    [
      Digest::SHA1.hexdigest(Time.now.to_f.to_s)[0..9],
      Digest::SHA1.hexdigest(Time.now.to_f.to_s)[0..15],
      Digest::SHA1.hexdigest(Time.now.to_f.to_s)
    ]
  end
end
