require 'spec_helper'

describe Link do
  it { should_not allow_value('example.com').for(:url) }
  it { should allow_value('http://example.com').for(:url) }
  it { should allow_value('https://example.com').for(:url) }
  it { should validate_presence_of(:url) }

  context 'instance' do
    subject(:link) { Fabricate(:link) }

    its(:url) { should_not be_blank }
  end

end
