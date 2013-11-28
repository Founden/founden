EasyAuth.config do |c|
  c.oauth2_client(
    :google,
    Founden::Config.oauth2_providers.google.client_id,
    Founden::Config.oauth2_providers.google.secret_key
  )
end
