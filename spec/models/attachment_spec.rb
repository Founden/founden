require 'spec_helper'

describe Attachment do
  it { should belong_to(:user) }
  it { should belong_to(:conversation) }
  it { should belong_to(:message) }
  it { should belong_to(:summary) }
  it { should validate_uniqueness_of(:slug) }

  context 'instance' do
    subject(:attachment) { Fabricate(:attachment) }

    it { should be_valid }
    its(:slug) { should eq(attachment.friendly_id) }

    context '#title' do
      let(:title) { Faker::HTMLIpsum.fancy_string[0..254] }

      before { attachment.update_attributes(:title => title) }

      its(:title) { should eq(Sanitize.clean(title)) }
    end
  end
end
