EasyAuth.config do |c|
  c.oauth2_client(
    :google,
    Founden::Config.google_client_id,
    Founden::Config.google_secret_key
  )
end
