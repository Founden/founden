require 'vcr'

VCR.configure do |c|
  c.hook_into :faraday
  c.cassette_library_dir = 'spec/cassettes'
  c.ignore_localhost = true
  c.configure_rspec_metadata!
  # c.debug_logger = $stdout

  c.around_http_request do |request|
    VCR.use_cassette('google_oauth2', &request)
  end
end
