module Founden::RSpecHelpers
  def try_google_sign_in(code_attr=:code)
    visit oauth2_callback_path(
      :provider => :google,
      code_attr => 'DUMMY_CODE'
    )
    if user = User.last
      user.update_attribute(:promo_code, Founden::Config.promo_codes.sample)
    end
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

  # Capybara helper to avoid calling `sleep` by checking active ajax requests
  def wait_for_ajax
    counter = 0
    wait_time = Capybara.default_wait_time
    while page.evaluate_script('$.active').to_i > 0
      counter += 1
      sleep(0.1)
      # Lets test failure raise error
      # if counter >= wait_time
      #   raise 'AJAX request took longer than %s seconds.' % wait_time
      # end
    end
  end
end

RSpec.configure do |config|
  config.include Founden::RSpecHelpers
end
