require 'spec_helper'

describe Network do
  it { should belong_to(:user) }

  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(
    :title).scoped_to(:user_id).case_insensitive }


  context 'instance' do
    subject(:network) { Fabricate(:network) }

    it { should be_valid }
    its(:slug) { should eq(network.friendly_id) }
  end
end
