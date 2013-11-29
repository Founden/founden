require 'digest/sha1'

module ObfuscatedId
  # Generates a hash to be used as the ID
  def obfuscated_id
    Digest::SHA1.hexdigest(Time.now.to_f.to_s)[0..9]
  end
end
