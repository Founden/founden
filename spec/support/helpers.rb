module Founden::RSpecHelpers
  def try_google_sign_in(code_attr=:code)
    visit oauth2_callback_path(
      :provider => :google,
      code_attr => 'DUMMY_CODE'
    )
  end

  # Parses a JSON into an OpenStruct data set
  # Remember, nested groups are not parsed, so [Hash] access is still needed
  #
  # @param [String] string, the JSON content
  # @param [Symbol] root, the JSON root to use
  def json_to_ostruct(string, root=nil)
    json = ActiveSupport::JSON.decode(string)
    return json if json.nil?
    ostruct = root ? OpenStruct.new(json[root.to_s]) : OpenStruct.new(json)
    ostruct.keys = root ? json[root.to_s].keys : json.keys
    ostruct
  end
end

RSpec.configure do |config|
  config.include Founden::RSpecHelpers
end
