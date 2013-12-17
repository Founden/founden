shared_examples 'an email from us' do
  its(:subject) { should include(Founden::Config.app_name) }
  its(:from) { should include(
    Mail::Address.new(Founden::Config.default_email).address) }
  its(:return_path) { should include(
    Mail::Address.new(Founden::Config.contact_email).address) }
end
