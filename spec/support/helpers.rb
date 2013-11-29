module Founden::RSpecHelpers
  def try_google_sign_in
    visit oauth2_callback_path(
      :provider => :google,
      :code => 'DUMMY_CODE'
    )
  end
end

RSpec.configure do |config|
  config.include Founden::RSpecHelpers
end
