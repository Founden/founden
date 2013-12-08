require 'spec_helper'

describe Summary do
  it { should belong_to(:network) }
  it { should belong_to(:conversation) }
  it { should have_many(:messages).dependent('') }

  it { should validate_presence_of(:network) }
  it { should validate_presence_of(:conversation) }
  it { should validate_uniqueness_of(:slug) }

  context 'instance' do
    subject(:summary) { Fabricate(:summary) }

    it { should be_valid }
    its(:slug) { should eq(summary.friendly_id) }

    context '#title' do
      let(:title) { Faker::HTMLIpsum.fancy_string[0..254] }

      before { summary.update_attributes(:title => title) }

      its(:title) { should eq(Sanitize.clean(title)) }
    end
  end
end
